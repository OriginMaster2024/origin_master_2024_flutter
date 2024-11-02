import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';
import 'package:origin_master_2024_flutter/page/situation_page.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';
import 'package:origin_master_2024_flutter/widgets/three_dimensional_container.dart';

class HotDogSelectPage extends HookWidget {
  const HotDogSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // NOTE: Disable iOS swipe back & Android back button
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ホットドッグ'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(32),
              const IngredientCard(type: 'パン', options: Bread.values),
              const Gap(32),
              const IngredientCard(type: 'ソーセージ', options: Sausage.values),
              const Spacer(),
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
                  title: "次へ",
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

class IngredientCard extends HookWidget {
  const IngredientCard({super.key, required this.type, required this.options});

  final String type;
  final List<Ingredient> options;

  Row buildIngredientInfoWidget(Ingredient ingredient) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ingredient.name,
                style: AppTextStyle.bold(color: Colors.black, fontSize: 26),
              ),
              Text(
                ingredient.description,
                style: AppTextStyle.medium(color: Colors.black, fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(width: 100, child: ingredient.image.svg(height: 140)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final selected = useState<Ingredient?>(null);
    Timer? timer;

    void startSelecting() {
      timer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
        selected.value = options[Random().nextInt(options.length)];
      });

      Future.delayed(const Duration(milliseconds: 1500), () {
        timer?.cancel();
      });
    }

    return ThreeDimensionalContainer(
      child: SizedBox(
        width: DeviceSize.width - 32,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$typeの種類',
                style: AppTextStyle.medium(color: Colors.black, fontSize: 12),
              ),
              const Gap(8),
              selected.value != null
                  ? buildIngredientInfoWidget(selected.value!)
                  : ActionButton(
                      onPressed: startSelecting,
                      title: '$typeを選ぶ',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class Ingredient {
  String get name;

  String get description;

  SvgGenImage get image;
}

enum Bread implements Ingredient {
  regular('レギュラーロール', '基本のホットドッグ用ロールで、柔らかくて少し甘みがあるのが特徴です。'),
  potato('ポテトロール', 'ジャガイモを使って作られたロールで、柔らかくもちもちした食感があります。'),
  brioche('ブリオッシュロール', 'フランスのブリオッシュ生地を使ったパンで、バターの風味が豊かでリッチな味わいです。'),
  wholeWheat('全粒粉ロール', 'ヘルシー志向の方に人気で、全粒粉を使っているため香ばしく、栄養価も高いです。');

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
      case Bread.wholeWheat:
        return Assets.svg.breadWholeWheat;
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
