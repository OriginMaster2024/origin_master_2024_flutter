import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/domain_object/personality_type.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';
import 'package:origin_master_2024_flutter/widgets/three_dimensional_container.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  // TODO: 定数を置き換える
  final String result = '''
  {
    "type": "リーダー気質",
    "description": "「リーダー気質」と診断されたあなたは、周囲を引きつけ、導く力を持つ人です。自信に満ち、前向きなエネルギーで人々をまとめ上げるのが得意で、積極的に行動します。決断力があり、冷静に対処するタイプです。"
  }
  ''';

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> json = jsonDecode(result);
    PersonalityType personalityType = PersonalityType.fromString(json['type']);
    String description = json['description'];

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
                      ThreeDimensionalContainer(
                        child: Container(
                          width: DeviceSize.width - 32,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("あなたの性格タイプは...", style: AppTextStyle.medium(color: Colors.black, fontSize: 12)),
                              const Gap(16),
                              Text(description, style: AppTextStyle.medium(color: Colors.black, fontSize: 12)),
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
