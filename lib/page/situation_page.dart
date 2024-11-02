import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';
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
              const Gap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ThreeDimensionalContainer(
                  child: selected.image,
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
  wave,
  highFive,
  dash,
  election,
  swimming,
  ;

  const Situation();

  String get description {
    switch (this) {
      case Situation.boxing:
        return 'ボクシングの試合中だ！\n相手のパンチを避けながらカウンターパンチ！';
      case Situation.wave:
        return 'ライブ中に左からウェーブが来た！\n周りに合わせてウェーブをしよう！';
      case Situation.highFive:
        return 'サッカー試合でPKを決めた！\nチームメンバーたちとハイタッチ！！';
      case Situation.dash:
        return '家を出るのが遅れてしまい、電車を逃しそうだ！\n最寄りの駅までダッシュをしよう！';
      case Situation.election:
        return '選挙に出馬し色んな人に知ってもらいたい！\n街ゆく人に挨拶をしよう！';
      case Situation.swimming:
        return '水泳大会ゴール目前！\nクロールで駆け抜けろ！！';
    }
  }

  Widget get image {
    switch (this) {
      case Situation.boxing:
        return Assets.png.situationBoxing.image();
      case Situation.wave:
        return Assets.png.situationWave.image();
      case Situation.highFive:
        return Assets.png.situationHighFive.image();
      case Situation.dash:
        return Assets.png.situationDash.image();
      case Situation.election:
        return Assets.png.situationElection.image();
      case Situation.swimming:
        return Assets.png.situationSwimming.image();
    }
  }
}
