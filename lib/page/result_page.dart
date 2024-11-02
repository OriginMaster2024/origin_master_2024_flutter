import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/domain_object/personality_type.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';
import 'package:origin_master_2024_flutter/widgets/three_dimensional_container.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  // TODO: 定数を置き換える
  final personalityType = PersonalityType.leader;

  @override
  Widget build(BuildContext context) {
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
                child: SizedBox(
                  width: DeviceSize.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Gap(32),
                      SizedBox(
                        width: DeviceSize.width - 128,
                        height: DeviceSize.width - 128,
                        child: ThreeDimensionalContainer(
                            child: personalityType.image,
                        ),
                      ),
                      const Gap(32),
                      const ThreeDimensionalContainer(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text("あなたの性格タイプは..."),
                              ],
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
              child: ActionButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
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
