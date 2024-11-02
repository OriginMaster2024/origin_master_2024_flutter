enum Situation {
  highFive,
  rainyDay,
  radioCalisthenics,
  swimming,
  entranceCeremony,
  ;

  const Situation();

  String get description {
    switch (this) {
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
