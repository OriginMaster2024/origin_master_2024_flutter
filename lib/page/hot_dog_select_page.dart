import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:origin_master_2024_flutter/page/situation_page.dart';

class HotDogSelectPage extends HookWidget {
  const HotDogSelectPage({super.key});

  static List<Color> breads = Colors.primaries;
  static List<Color> sausages = Colors.primaries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホットドッグ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const IngredientCard(type: 'パン', options: Colors.primaries),
            const IngredientCard(type: 'ソーセージ', options: Colors.primaries),
            TextButton(
              onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<SituationPage>(
                builder: (context) => const SituationPage(),
              ),
            );
          },
              child: const Text('診断開始'),
            ),
          ],
        ),
      ),
    );
  }
}

class IngredientCard extends HookWidget {
  const IngredientCard({super.key, required this.type, required this.options});

  final String type;
  final List<Color> options;

  @override
  Widget build(BuildContext context) {
    final selected = useState<Color?>(null);
    Timer? timer;

    void startSelecting() {
      timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        selected.value = options[Random().nextInt(options.length)];
      });

      Future.delayed(const Duration(seconds: 1), () {
        timer?.cancel();
      });
    }

    return Container(
      width: 300,
      height: 150,
      color: selected.value,
      child: Column(
        children: [
          Text('$typeの種類'),
          if (selected.value == null) ElevatedButton(
            onPressed: startSelecting,
            child: const Text('選択'),
          ),
        ],
      ),
    );
  }
}
