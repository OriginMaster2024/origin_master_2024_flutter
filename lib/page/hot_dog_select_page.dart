import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/page/situation_page.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';

class HotDogSelectPage extends HookWidget {
  const HotDogSelectPage({super.key});

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
            const IngredientCard(type: 'パン', options: Bread.values),
            const IngredientCard(type: 'ソーセージ', options: Sausage.values),
            SizedBox(
              width: DeviceSize.width - 32,
              child: ActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<SituationPage>(
                      builder: (context) => const SituationPage(),
                    ),
                  );
                },
                title: "診断をはじめる",
              ),
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
  final List<Ingredient> options;

  @override
  Widget build(BuildContext context) {
    final selected = useState<Ingredient?>(null);
    Timer? timer;

    void startSelecting() {
      timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        selected.value = options[Random().nextInt(options.length)];
      });

      Future.delayed(const Duration(seconds: 1), () {
        timer?.cancel();
      });
    }

    return SizedBox(
      width: 300,
      height: 150,
      child: Column(
        children: [
          Text('$typeの種類'),
          Text(selected.value?.name ?? ''),
          Text(selected.value?.description ?? ''),
          if (selected.value == null) ElevatedButton(
            onPressed: startSelecting,
            child: const Text('選択'),
          ),
        ],
      ),
    );
  }
}

abstract class Ingredient {
  String get name;
  String get description;
}

enum Bread implements Ingredient {
  whiteBread('White Bread', 'A soft and fluffy white bread, perfect for sandwiches.'),
  wholeWheat('Whole Wheat', 'A hearty and healthy whole wheat bread.'),
  sourdough('Sourdough', 'A tangy sourdough bread with a crispy crust.');

  @override
  final String name;
  @override
  final String description;

  const Bread(this.name, this.description);
}

enum Sausage implements Ingredient {
  porkSausage('Pork Sausage', 'A savory pork sausage with a juicy flavor.'),
  beefSausage('Beef Sausage', 'A rich beef sausage with a bold taste.'),
  chickenSausage('Chicken Sausage', 'A lighter sausage made from chicken.');

  @override
  final String name;
  @override
  final String description;

  const Sausage(this.name, this.description);
}
