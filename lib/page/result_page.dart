import 'package:flutter/material.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('診断結果'),
      ),
      body: Center(
        child: SizedBox(
          width: DeviceSize.width - 32,
          child: ActionButton(
            onPressed: () {},
            title: "おわる",
          ),
        ),
      ),
    );
  }
}
