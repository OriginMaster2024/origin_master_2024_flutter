import 'package:flutter/material.dart';
import 'package:origin_master_2024_flutter/page/etude_page.dart';

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
          child: const Text('決定'),
        ),
      ),
    );
  }
}
