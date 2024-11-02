import 'package:flutter/material.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/page/etude_page.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';

class SituationPage extends StatelessWidget {
  const SituationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('シチュエーション'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<EtudePage>(
                builder: (context) => const EtudePage(),
              ),
            );
          },
          child: SizedBox(
            width: DeviceSize.width - 32,
            child: ActionButton(
              onPressed: () {},
              title: "診断をはじめる",
            ),
          ),
        ),
      ),
    );
  }
}
