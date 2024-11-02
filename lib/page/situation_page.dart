import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/domain_object/situation.dart';
import 'package:origin_master_2024_flutter/page/etude_page.dart';
import 'package:origin_master_2024_flutter/providers/situation_provider.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';
import 'package:origin_master_2024_flutter/widgets/three_dimensional_container.dart';

class SituationPage extends HookConsumerWidget {
  const SituationPage({super.key});

  final List<Situation> situations = Situation.values;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final situation = ref.watch(situationProvider);

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
                  child: Text(
                    situation.description,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.medium(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Gap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ThreeDimensionalContainer(
                  child: situation.image,
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
