import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';
import 'package:sensors_plus/sensors_plus.dart';

const _breadSizeRatio = 0.7;
const _sausageSizeRatio = 0.75;
const _sausageMoveSpeed = 10;

class EtudePage extends HookConsumerWidget {
  const EtudePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeviceFrontHorizontal = useState(false);

    final countDownCount = useState(3);
    final countDownTimer = useState<Timer?>(null);
    final isCountDownTimerRunning = countDownTimer.value != null;

    final gameTimeCount = useState(10);
    final gameTimer = useState<Timer?>(null);
    final isGameTimerRunning = gameTimer.value != null;

    final sausageHeight = MediaQuery.sizeOf(context).height * _sausageSizeRatio;
    final sausageTopPosition =
        useState((MediaQuery.sizeOf(context).height - sausageHeight) / 2);

    void startGameTimer() {
      gameTimer.value = Timer.periodic(
        const Duration(seconds: 1),
        (t) {
          gameTimeCount.value--;
          if (gameTimeCount.value == 0) {
            t.cancel();
            gameTimer.value = null;
            gameTimeCount.value = 10;
            // TODO: ゲーム終了処理
          }
        },
      );
    }

    void startCountDownTimer() {
      countDownTimer.value = Timer.periodic(
        const Duration(seconds: 1),
        (t) {
          countDownCount.value--;
          if (countDownCount.value == 0) {
            t.cancel();
            countDownTimer.value = null;
            countDownCount.value = 3;
            startGameTimer();
          }
        },
      );
    }

    useEffect(
      () {
        final subscription = accelerometerEventStream().listen((event) {
          isDeviceFrontHorizontal.value = event.y.abs() < 3 && event.z > 9.0;
          if (isGameTimerRunning) {
            sausageTopPosition.value += event.y * _sausageMoveSpeed;
          }
        });
        return subscription.cancel;
      },
      [isGameTimerRunning],
    );

    return Scaffold(
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
          if (isGameTimerRunning)
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
              style: AppTextStyle.bold(fontSize: 64, color: Colors.yellow),
            ),
          if (!isGameTimerRunning && !isCountDownTimerRunning)
            // TODO: ボタン差し替える
            FilledButton(
              onPressed:
                  isDeviceFrontHorizontal.value ? startCountDownTimer : null,
              child: Text(
                isDeviceFrontHorizontal.value ? 'スタート' : '🌭画面を水平にしてください🌭',
              ),
            ),
        ],
      ),
    );
  }
}
