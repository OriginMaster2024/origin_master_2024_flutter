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
    final gyroscopeEvent = useState("");

    useEffect(
      () {
        final userAccelerometerEventSubscription =
            userAccelerometerEventStream()
                .listen((UserAccelerometerEvent event) {
          userAccelerometerEvent.value = event.toString();
        });
        final gyroscopeEventSubscription =
            gyroscopeEventStream().listen((GyroscopeEvent event) {
          gyroscopeEvent.value = event.toString();
        });
        return () {
          userAccelerometerEventSubscription.cancel();
          gyroscopeEventSubscription.cancel();
        };
      },
      const [],
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(userAccelerometerEvent.value, style: AppTextStyle.medium()),
          const Gap(24),
          Text(gyroscopeEvent.value, style: AppTextStyle.medium()),
        ],
      ),
    );
  }
}
