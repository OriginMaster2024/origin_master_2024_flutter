import 'package:flutter/material.dart';
import 'package:origin_master_2024_flutter/page/situation_page.dart';

class HotDogSelectPage extends StatelessWidget {
  const HotDogSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホットドッグ'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<SituationPage>(
                builder: (context) => const SituationPage(),
              ),
            );
          },
          child: const Text('決定'),
        ),
      ),
    );
  }
}
