import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';
import 'package:sensors_plus/sensors_plus.dart';

class EtudePage extends HookConsumerWidget {
  const EtudePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accelerometerEvent = useState("");

    useEffect(
      () {
        final accelerometerEventSubscription =
            accelerometerEventStream().listen((event) {
          accelerometerEvent.value =
              "加速度センサー\n${event.x.toStringAsFixed(2)}\n${event.y.toStringAsFixed(2)}\n${event.z.toStringAsFixed(2)}";
        });
        return () {
          accelerometerEventSubscription.cancel();
        };
      },
      const [],
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(accelerometerEvent.value, style: AppTextStyle.medium()),
          ],
        ),
      ),
    );
  }
}
