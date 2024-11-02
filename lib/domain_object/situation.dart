import 'package:flutter/material.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';

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
