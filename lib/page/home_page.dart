import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/constants/device_size.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';
import 'package:origin_master_2024_flutter/page/description_page.dart';
import 'package:origin_master_2024_flutter/providers/audio_player_provider.dart';
import 'package:origin_master_2024_flutter/widgets/action_button.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeBGMPlayer = ref.watch(homeBGMPlayerProvider);
    final safeAreaTop = MediaQuery.paddingOf(context).top;
    final screenSize = DeviceSize.size;
    final SvgPicture hotdog = Assets.svg.hotdog.svg(width: 150);

    final position = useState<Offset>(const Offset(100.0, 100.0));
    final velocity = useState<Offset>(const Offset(1.5, 1.5));

    final animationController = useAnimationController(
      duration: const Duration(days: 1),
    )..repeat();

    useEffect(
      () {
        animationController.addListener(() {
          position.value += velocity.value;

          if (position.value.dx <= 0 ||
              position.value.dx + hotdog.width! >= screenSize.width) {
            velocity.value = Offset(-velocity.value.dx, velocity.value.dy);
          }
          if (position.value.dy <= 0 ||
              position.value.dy + 295 >= screenSize.height) {
            velocity.value = Offset(velocity.value.dx, -velocity.value.dy);
          }
        });

        return null;
      },
      [animationController],
    );

    useEffect(
      () {
        if (homeBGMPlayer?.state != PlayerState.playing) {
          homeBGMPlayer?.resume();
        }
        return null;
      },
      [homeBGMPlayer],
    );

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: position.value.dx,
            top: position.value.dy,
            child: hotdog,
          ),
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
            bottom: 64,
            child: ActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const DescriptionPage(),
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
