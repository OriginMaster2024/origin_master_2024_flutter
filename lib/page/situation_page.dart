import 'package:flutter/material.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/page/etude_page.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';

class SituationPage extends StatelessWidget {
  const SituationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // NOTE: Disable iOS swipe back & Android back button
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('シチュエーション'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: SizedBox(
            width: DeviceSize.width - 32,
            child: ActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<EtudePage>(
                    builder: (context) => const EtudePage(),
                  ),
                );
              },
              title: "診断をはじめる",
            ),
          ),
        ),
      ),
    );
  }
}
