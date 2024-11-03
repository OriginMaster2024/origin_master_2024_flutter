import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/domain_object/etude_result.dart';
import 'package:origin_master_2024_flutter/exceptions/hot_dog_exception.dart';
import 'package:origin_master_2024_flutter/page/result_page.dart';
import 'package:origin_master_2024_flutter/providers/audio_player_provider.dart';
import 'package:origin_master_2024_flutter/providers/difficulty_provider.dart';
import 'package:origin_master_2024_flutter/providers/ingredient_provider.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';
import 'package:sensors_plus/sensors_plus.dart';

const _breadSizeRatio = 0.7;
const _sausageSizeRatio = 0.75;


class EtudePage extends HookConsumerWidget {
  const EtudePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeBGMPlayer = ref.watch(homeBGMPlayerProvider);
    final etudeBGMPlayer = ref.watch(etudeBGMPlayerProvider);
    final countDownSEPlayer = ref.watch(coundDownSEPlayerProvider);

    final bread = ref.watch(breadProvider);
    final sausage = ref.watch(sausageProvider);
    final difficulty = ref.watch(difficultyProvider);

    if (bread == null || sausage == null || difficulty == null) {
      return const SizedBox.shrink();
    }

    final centerPercentages = useState(<double>[]);
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
      HapticFeedback.vibrate();
      etudeBGMPlayer?.pause();
      gameTimer.value?.cancel();
      gameTimer.value = null;
      isGameFailed.value = true;
      throw const HotDogException('🌭が落ちちゃった！');
    }

    void showResultPage() {
      homeBGMPlayer
        ?..seek(Duration.zero)
        ..resume();

      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ResultPage(
            result: isGameSucceeded.value
                ? EtudeResult.success
                : EtudeResult.failure,
            centerPercentages: centerPercentages.value,
          ),
        ),
      );
    }

    useEffect(
      () {
        final subscription = accelerometerEventStream().listen((event) {
          isDeviceFrontHorizontal.value = event.y.abs() < 3 && event.z > 9.0;
          if (isGameTimerRunning) {
            sausageTopPosition.value += event.y * difficulty.sausageMoveSpeed;
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

            final sausaceCenter = sausageTopPosition.value + sausageHeight / 2;
            final breadCenter = breadTopPosition + breadHeight / 2;
            final sausageCenterPercentage = max<double>(
              1 - ((sausaceCenter - breadCenter) / breadHeight).abs(),
              0,
            );

            centerPercentages.value.add(
              (sausageCenterPercentage * 100).round() / 100,
            );
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
            bread.image.svg(
              width: MediaQuery.sizeOf(context).width * _breadSizeRatio,
              height: MediaQuery.sizeOf(context).height * _breadSizeRatio,
            ),
            AnimatedPositioned(
              duration: SensorInterval.normalInterval,
              top: sausageTopPosition.value,
              child: sausage.image.svg(
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
              isDeviceFrontHorizontal.value
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ActionButton(
                        onPressed: isDeviceFrontHorizontal.value
                            ? startCountDownTimer
                            : null,
                        title: 'スタート',
                      ),
                    )
                  : Container(
                      height: 64,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        border: Border.all(color: Colors.black, width: 4),
                      ),
                      child: Center(
                        child: Text(
                          '🌭画面を水平にしてください🌭',
                          style: AppTextStyle.bold(fontSize: 16),
                        ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ActionButton(
                      onPressed: showResultPage,
                      title: '診断結果へ',
                    ),
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
