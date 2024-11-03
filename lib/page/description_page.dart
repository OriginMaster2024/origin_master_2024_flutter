import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';
import 'package:origin_master_2024_flutter/page/hot_dog_select_page.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';
import 'package:origin_master_2024_flutter/widgets/three_dimensional_container.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホットドッグ・エチュードとは'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Gap(32),
            ThreeDimensionalContainer(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Text(
                  'ホットドッグ・エチュードとは、ホットドッグを持っている状況を想定し、さまざまなシチュエーションを演じながら行う『ホットドッグ持ち方診断』です。ホットドッグの持ち方から、『リーダー気質』『自由人』など、その人の性格を分析します。',
                  style: AppTextStyle.medium(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const Gap(24),
            Assets.png.situations.image(),
            const Spacer(),
            ActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const HotDogSelectPage(),
                  ),
                );
              },
              title: "ホットドッグを選ぶ",
            ),
            const Gap(64),
          ],
        ),
      ),
    );
  }
}
