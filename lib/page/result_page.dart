import 'package:flutter/material.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';
import 'package:origin_master_2024_flutter/widgets/three_dimensional_container.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

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
                      ThreeDimensionalContainer(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text("あなたの性格タイプは...")
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 64),
              child: ActionButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                title: "おわる",
              ),
            )
          ],
        ),
      ),
    );
  }
}

// TODO: Move to DomainObjects folder
enum PersonalityType {
  leader,
  freeSpirited,
  seeker,
  revolutionary,
  stabilityOriented,
}

extension PersonalityTypeExtension on PersonalityType {
  AssetGenImage get image {
    return switch (this){
      PersonalityType.leader => Assets.png.leader,
      PersonalityType.freeSpirited => Assets.png.freeSpirited,
      PersonalityType.seeker => Assets.png.seeker,
      PersonalityType.revolutionary => Assets.png.revolutionary,
      PersonalityType.stabilityOriented => Assets.png.stabilityOriented,
    };
  }
}