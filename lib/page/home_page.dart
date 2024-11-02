import 'package:flutter/material.dart';
import 'package:origin_master_2024_flutter/page/hot_dog_select_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホットドッグ・エチュード'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<HotDogSelectPage>(
                builder: (context) => const HotDogSelectPage(),
              ),
            );
          },
          child: const Text('診断開始'),
        ),
      ),
    );
  }
}
