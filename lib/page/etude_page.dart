import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';
import 'package:sensors_plus/sensors_plus.dart';

class EtudePage extends HookConsumerWidget {
  const EtudePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAccelerometerEvent = useState("");
    final accelerometerEvent = useState("");
    final gyroscopeEvent = useState("");

    useEffect(
      () {
        // final userAccelerometerEventSubscription =
        //     userAccelerometerEventStream().listen((event) {
        //   userAccelerometerEvent.value =
        //       "加速度センサー\n${event.x.toStringAsFixed(2)}\n${event.y.toStringAsFixed(2)}\n${event.z.toStringAsFixed(2)}";
        // });
        final accelerometerEventSubscription =
            accelerometerEventStream().listen((event) {
          accelerometerEvent.value =
              "加速度センサー\n${event.x.toStringAsFixed(2)}\n${event.y.toStringAsFixed(2)}\n${event.z.toStringAsFixed(2)}";
        });
        // final gyroscopeEventSubscription =
        //     gyroscopeEventStream().listen((GyroscopeEvent event) {
        //   final angle = Offset(
        //     event.x * 180 / pi,
        //     event.y * 180 / pi,
        //   );
        //   gyroscopeEvent.value =
        //       "dx: ${angle.dx.toStringAsFixed(2)}\ndy: ${angle.dy.toStringAsFixed(2)}";
        //   // "ジャイロセンサー\n${event.x.toStringAsFixed(2)}\n${event.y.toStringAsFixed(2)}\n${event.z.toStringAsFixed(2)}";
        // });
        return () {
          // userAccelerometerEventSubscription.cancel();
          accelerometerEventSubscription.cancel();
          // gyroscopeEventSubscription.cancel();
        };
      },
      const [],
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(userAccelerometerEvent.value, style: AppTextStyle.medium()),
            // const Gap(24),
            Text(accelerometerEvent.value, style: AppTextStyle.medium()),
            // const Gap(24),
            // Text(gyroscopeEvent.value, style: AppTextStyle.medium()),
          ],
        ),
      ),
    );
  }
}
