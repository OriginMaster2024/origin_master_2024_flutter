import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/domain_object/etude_result.dart';
import 'package:origin_master_2024_flutter/providers/ingredient_provider.dart';
import 'package:origin_master_2024_flutter/providers/personal_diagnosis_provider.dart';
import 'package:origin_master_2024_flutter/providers/situation_provider.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';
import 'package:origin_master_2024_flutter/widgets/three_dimensional_container.dart';

class ResultPage extends HookConsumerWidget {
  const ResultPage({
    super.key,
    required this.result,
    required this.centerPercentages,
  });

  final EtudeResult result;
  final List<double> centerPercentages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalDiagnosis = ref.watch(personalDiagnosisProvider);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.watch(personalDiagnosisProvider.notifier).call(
                situation: ref.read(situationProvider).name,
                result: result,
                centerPercentages: centerPercentages,
              );
        });
        return null;
      },
      const [],
    );

    return PopScope(
      // NOTE: Disable iOS swipe back & Android back button
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('診断結果'),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Gap(32),
                    SizedBox(
                      width: DeviceSize.width - 128,
                      height: DeviceSize.width - 128,
                      child: ThreeDimensionalContainer(
                        child: personalDiagnosis.value?.type.image ??
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    const Gap(32),
                    ThreeDimensionalContainer(
                      child: Container(
                        width: DeviceSize.width - 32,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "あなたの性格タイプは...",
                              style: AppTextStyle.medium(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            const Gap(10),
                            if (personalDiagnosis.isLoading)
                              const Center(child: CircularProgressIndicator()),
                            if (!personalDiagnosis.isLoading) ...[
                              SizedBox(
                                height: 26,
                                child: personalDiagnosis.value?.type.titleImage,
                              ),
                              const Gap(10),
                              Text(
                                personalDiagnosis.value?.description ?? "",
                                style: AppTextStyle.medium(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
              child: ActionButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);

                  ref
                    ..invalidate(breadProvider)
                    ..invalidate(sausageProvider)
                    ..invalidate(situationProvider)
                    ..invalidate(personalDiagnosisProvider);
                },
                title: "おわる",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
