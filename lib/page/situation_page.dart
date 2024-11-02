import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/page/etude_page.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';
import 'package:origin_master_2024_flutter/widgets/three_dimensional_container.dart';

class SituationPage extends StatelessWidget {
  const SituationPage({super.key});

  final List<Situation> situations = Situation.values;

  @override
  Widget build(BuildContext context) {
    Situation selected = Situation.values[Random().nextInt(Situation.values.length)];

    return PopScope(
      // NOTE: Disable iOS swipe back & Android back button
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('シチュエーション'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: [
              const Gap(32),
              ThreeDimensionalContainer(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  width: DeviceSize.width - 32,
                  height: 200,
                  child: Text(selected.description, textAlign: TextAlign.center, style: AppTextStyle.medium(color: Colors.black, fontSize: 20)),
                ),
              ),
              const Spacer(),
              SizedBox(
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
              const Gap(64),
            ],
          ),
        ),
      ),
    );
  }
}

enum Situation {
  boxing,
  highFive,
  rainyDay,
  radioCalisthenics,
  swimming,
  entranceCeremony,
  ;

  const Situation();

  String get description {
    switch (this) {
      case Situation.boxing:
        return 'ボクシングの試合中だ！\n相手のパンチを避けながらカウンターパンチ！';
      case Situation.highFive:
        return 'サッカー試合でPKを決めた！\nチームメンバーたちとハイタッチ！！';
      case Situation.rainyDay:
        return '激しい雨風で傘がひっくり返ってしまった！\n風で傘が飛ばされてしまいそう！！';
      case Situation.radioCalisthenics:
        return 'ラジオ体操第一！\n腕を回す運動！！';
      case Situation.swimming:
        return '水泳大会ゴール目前！\nクロールで駆け抜けろ！！';
      case Situation.entranceCeremony:
        return '入学式で新入生代表スピーチ！\n壇上で原稿を読み終えて一礼！！';
    }
  }
}
