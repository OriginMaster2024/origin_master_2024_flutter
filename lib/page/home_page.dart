import 'package:flutter/material.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';
import 'package:origin_master_2024_flutter/page/hot_dog_select_page.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final safeAreaTop = MediaQuery.paddingOf(context).top;
    final safeAreaBottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: safeAreaTop > 0 ? 0 : -40,
            left: -40,
            right: -40,
            child: Assets.png.homeTopBar.image(),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Assets.png.homeLabel.image(),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: safeAreaBottom + 80,
            child: ActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<HotDogSelectPage>(
                    builder: (context) => const HotDogSelectPage(),
                  ),
                );
              },
              title: "はじめる",
            ),
          ),
        ],
      ),
    );
  }
}
