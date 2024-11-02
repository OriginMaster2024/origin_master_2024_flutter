import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';
import 'package:origin_master_2024_flutter/page/result_page.dart';
import 'package:origin_master_2024_flutter/providers/audio_player_provider.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';
import 'package:sensors_plus/sensors_plus.dart';

const _breadSizeRatio = 0.7;
const _sausageSizeRatio = 0.75;

// NOTE: これを変えるとゲームの難易度が変わる
const _sausageMoveSpeed = 100;

class EtudePage extends HookConsumerWidget {
  const EtudePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeBGMPlayer = ref.watch(homeBGMPlayerProvider);
    final etudeBGMPlayer = ref.watch(etudeBGMPlayerProvider);
    final countDownSEPlayer = ref.watch(coundDownSEPlayerProvider);

    final isDeviceFrontHorizontal = useState(false);

    final countDownCount = useState(3);
    final countDownTimer = useState<Timer?>(null);
    final isCountDownTimerRunning = countDownTimer.value != null;

    final gameTimeCount = useState(10);
    final gameTimer = useState<Timer?>(null);
    final isGameTimerRunning = gameTimer.value != null;

    final isGameFailed = useState(false);
    final isGameSucceeded = useState(false);

    final breadHeight = useMemoized(
      () => MediaQuery.sizeOf(context).height * _breadSizeRatio,
      [context, _breadSizeRatio],
    );
    final breadTopPosition = useMemoized(
      () => (MediaQuery.sizeOf(context).height - breadHeight) / 2,
      [context, breadHeight],
    );
    final breadBottomPosition = useMemoized(
      () => breadTopPosition + breadHeight,
      [breadTopPosition, breadHeight],
    );

    final sausageHeight = useMemoized(
      () => MediaQuery.sizeOf(context).height * _sausageSizeRatio,
      [context, _sausageSizeRatio],
    );
    final sausageTopPosition =
        useState((MediaQuery.sizeOf(context).height - sausageHeight) / 2);

    void startGameTimer() {
      etudeBGMPlayer?.resume();

      gameTimer.value = Timer.periodic(
        const Duration(seconds: 1),
        (t) {
          gameTimeCount.value--;
          if (gameTimeCount.value == 0) {
            etudeBGMPlayer?.pause();
            t.cancel();
            gameTimer.value = null;
            gameTimeCount.value = 10;
            isGameSucceeded.value = true;
          }
        },
      );
    }

    void startCountDownTimer() {
      homeBGMPlayer?.pause();
      countDownSEPlayer
        ?..seek(Duration.zero)
        ..resume();

      countDownTimer.value = Timer.periodic(
        const Duration(seconds: 1),
        (t) {
          countDownCount.value--;
          if (countDownCount.value == 0) {
            t.cancel();
            countDownTimer.value = null;
            countDownCount.value = 3;
            startGameTimer();
          } else {
            countDownSEPlayer
              ?..seek(Duration.zero)
              ..resume();
          }
        },
      );
    }

    void failedGame() {
      etudeBGMPlayer?.pause();
      gameTimer.value?.cancel();
      gameTimer.value = null;
      isGameFailed.value = true;
    }

    void showResultPage() {
      homeBGMPlayer
        ?..seek(Duration.zero)
        ..resume();

      Navigator.of(context).push(
        MaterialPageRoute<ResultPage>(
          builder: (context) => const ResultPage(),
        ),
      );
    }

    useEffect(
      () {
        final subscription = accelerometerEventStream().listen((event) {
          isDeviceFrontHorizontal.value = event.y.abs() < 3 && event.z > 9.0;
          if (isGameTimerRunning) {
            sausageTopPosition.value += event.y * _sausageMoveSpeed;
            final sausageBottomPosition =
                sausageTopPosition.value + sausageHeight;
            final topDiff = sausageBottomPosition - breadTopPosition;
            final bottomDiff = sausageTopPosition.value - breadBottomPosition;

            if (topDiff < 0) {
              // 上側に落ちた場合
              failedGame();
            } else if (bottomDiff > 0) {
              // 下側に落ちた場合
              failedGame();
            } else if (topDiff < breadHeight / 2) {
              // 上側に半分落ちかけ
            } else if (bottomDiff > breadHeight / 2) {
              // 下側に半分落ちかけ
            }
          }
        });
        return subscription.cancel;
      },
      [isGameTimerRunning],
    );

    return PopScope(
      // NOTE: Disable iOS swipe back & Android back button
      canPop: false,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              color: Colors.white,
            ),
            Assets.svg.bread.svg(
              width: MediaQuery.sizeOf(context).width * _breadSizeRatio,
              height: MediaQuery.sizeOf(context).height * _breadSizeRatio,
            ),
            AnimatedPositioned(
              duration: SensorInterval.normalInterval,
              top: sausageTopPosition.value,
              child: Assets.svg.sausage.svg(
                width: MediaQuery.sizeOf(context).width * _sausageSizeRatio,
                height: sausageHeight,
              ),
            ),
            if (isGameTimerRunning || isGameFailed.value)
              Positioned(
                top: MediaQuery.viewPaddingOf(context).top + 16,
                right: 16,
                child: Text(
                  '残り時間: ${gameTimeCount.value}',
                  style: AppTextStyle.bold(fontSize: 24),
                ),
              ),
            if (!isGameTimerRunning) Container(color: Colors.black45),
            if (isCountDownTimerRunning)
              Text(
                countDownCount.value.toString(),
                style: AppTextStyle.bold(fontSize: 120, color: Colors.yellow),
              ),
            if (!isGameTimerRunning &&
                !isCountDownTimerRunning &&
                !isGameFailed.value &&
                !isGameSucceeded.value)
              // TODO: ボタン差し替える
              FilledButton(
                onPressed:
                    isDeviceFrontHorizontal.value ? startCountDownTimer : null,
                child: Text(
                  isDeviceFrontHorizontal.value ? 'スタート' : '🌭画面を水平にしてください🌭',
                ),
              ),
            if (isGameFailed.value || isGameSucceeded.value) ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isGameFailed.value ? '🌭が落ちちゃった！' : '🌭をキープできた！',
                    style: AppTextStyle.bold(fontSize: 32, color: Colors.white),
                  ),
                  const Gap(24),
                  FilledButton(
                    onPressed: showResultPage,
                    child: const Text('診断結果へ'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
