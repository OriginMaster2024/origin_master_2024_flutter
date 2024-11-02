import 'package:origin_master_2024_flutter/gen/assets.gen.dart';

abstract class Ingredient {
  String get name;

  String get description;

  SvgGenImage get image;
}

enum Bread implements Ingredient {
  regular('レギュラーロール', '基本のホットドッグ用ロールで、柔らかくて少し甘みがあるのが特徴です。'),
  potato('ポテトロール', 'ジャガイモを使って作られたロールで、柔らかくもちもちした食感があります。'),
  brioche('ブリオッシュロール', 'フランスのブリオッシュ生地を使ったパンで、バターの風味が豊かでリッチな味わいです。'),
  french('フランスパンロール', 'フランスパンのような固めのロールで、クラストがしっかりとしていて、食べごたえがあります。');

  const Bread(this.name, this.description);

  @override
  final String name;
  @override
  final String description;

  @override
  SvgGenImage get image {
    switch (this) {
      case Bread.regular:
        return Assets.svg.breadRegular;
      case Bread.potato:
        return Assets.svg.breadPotato;
      case Bread.brioche:
        return Assets.svg.breadBrioche;
      case Bread.french:
        return Assets.svg.breadFrench;
    }
  }
}

enum Sausage implements Ingredient {
  chorizo(
    'チョリソー',
    'ピリッとした辛さがあり、熟成されており、風味が濃厚です。ピリ辛の味わいがアクセントになります。',
  ),
  bratwurst(
    'ブラートヴルスト',
    'ドイツを代表するソーセージで、マイルドでジューシーな味わいが特徴ですが、ハーブやスパイスで軽く味付けされており、食べ応えがあります。',
  ),
  frankfurter(
    'フランクフルト',
    'ドイツのフランクフルト発祥のソーセージで、スモークされていることが多く、肉の旨味が強調されています。',
  ),
  wiener(
    'ウィンナー',
    'オーストリアのウィーン発祥のソーセージで、細くて短めのサイズが特徴。スモークしてあることが多く、パリッとした食感です。',
  );

  const Sausage(this.name, this.description);

  @override
  final String name;
  @override
  final String description;

  @override
  SvgGenImage get image {
    switch (this) {
      case chorizo:
        return Assets.svg.sausageChorizo;
      case bratwurst:
        return Assets.svg.sausageBratwurst;
      case frankfurter:
        return Assets.svg.sausageFrankfurter;
      case wiener:
        return Assets.svg.sausageWiener;
    }
  }
}
