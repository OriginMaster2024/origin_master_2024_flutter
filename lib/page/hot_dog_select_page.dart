import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/domain_object/ingredient.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';
import 'package:origin_master_2024_flutter/page/situation_page.dart';
import 'package:origin_master_2024_flutter/providers/ingredient_provider.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';
import 'package:origin_master_2024_flutter/widgets/three_dimensional_container.dart';

class HotDogSelectPage extends HookConsumerWidget {
  const HotDogSelectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bread = ref.watch(breadProvider);
    final breadNotifier = ref.watch(breadProvider.notifier);
    final sausage = ref.watch(sausageProvider);
    final sausageNotifier = ref.watch(sausageProvider.notifier);

    final isNextButtonEnabled = bread != null && sausage != null;

    void onBreadSelected(Bread bread) {
      breadNotifier.state = bread;
    }

    void onSausageSelected(Sausage sausage) {
      sausageNotifier.state = sausage;
    }

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
              IngredientCard(
                type: 'パン',
                options: Bread.values,
                onSelected: onBreadSelected,
              ),
              const Gap(32),
              IngredientCard(
                type: 'ソーセージ',
                options: Sausage.values,
                onSelected: onSausageSelected,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ActionButton(
                  onPressed: isNextButtonEnabled
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute<SituationPage>(
                              builder: (context) => const SituationPage(),
                            ),
                          );
                        }
                      : null,
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

class IngredientCard<T extends Ingredient> extends HookWidget {
  const IngredientCard({
    super.key,
    required this.type,
    required this.options,
    required this.onSelected,
  });

  final String type;
  final List<T> options;
  final void Function(T) onSelected;

  Widget buildIngredientInfoWidget(T ingredient) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ingredient.titleImage.image(height: 32),
                  const Gap(8),
                  Text(
                    ingredient.description,
                    style: AppTextStyle.medium(color: Colors.black87, fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(width: 100, child: ingredient.image.svg(height: 140)),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Text(
              "すべりやすさ",
              style: AppTextStyle.bold(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const Gap(8),
            warningSlippingImage(level: ingredient.slippingLevel),
          ],
        )
      ],
    );
  }

  Widget warningSlippingImage({required int level}) {
    switch (level) {
      case 1:
        return Assets.png.warningSlippingLevel1.image(height: 48);
      case 2:
        return Assets.png.warningSlippingLevel2.image(height: 48);
      case 3:
        return Assets.png.warningSlippingLevel3.image(height: 48);
      default:
        return Assets.png.warningSlippingLevel4.image(height: 48);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = useState<T?>(null);
    Timer? timer;

    void startSelecting() {
      int index = 0;
      timer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
        selected.value = options[index];
        index = (index + 1) % options.length;
      });

      Future.delayed(const Duration(milliseconds: 1500), () {
        selected.value = options[Random().nextInt(options.length)];
        onSelected(selected.value!);
        timer?.cancel();
      });
    }

    return ThreeDimensionalContainer(
      child: Container(
        width: DeviceSize.width - 32,
        height: 270,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$typeの種類',
              style: AppTextStyle.bold(color: Colors.black, fontSize: 12),
            ),
            const Gap(8),
            selected.value != null
                ? Expanded(child: buildIngredientInfoWidget(selected.value!))
                : Padding(
                    padding: const EdgeInsets.fromLTRB(80, 40, 80, 0),
                    child: ActionButton(
                      onPressed: startSelecting,
                      title: '$typeを選ぶ',
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
