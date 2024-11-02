import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';
import 'package:origin_master_2024_flutter/page/hot_dog_select_page.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final safeAreaTop = MediaQuery.paddingOf(context).top;
    final safeAreaBottom = MediaQuery.paddingOf(context).bottom;

    useEffect(
      () {
        final player = AudioPlayer()..setReleaseMode(ReleaseMode.loop);
        player.play(
          AssetSource(
            Assets.music.timelessJourney.replaceFirst('assets/', ''),
          ),
        );
        return player.dispose;
      },
      const [],
    );

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: safeAreaTop > 0 ? 0 : -40,
            left: -40,
            right: -40,
            child: Assets.png.homeTopBar.image(),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Assets.png.homeLabel.image(),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: safeAreaBottom + 80,
            child: ActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<HotDogSelectPage>(
                    builder: (context) => const HotDogSelectPage(),
                  ),
                );
              },
              title: "はじめる",
            ),
          ),
        ],
      ),
    );
  }
}
