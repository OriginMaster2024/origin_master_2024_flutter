import 'package:audioplayers/audioplayers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';

final homeBGMPlayerProvider = Provider<AudioPlayer?>((ref) {
  return ref
      .watch(_audioPlayerFutureProvider(Assets.music.timelessJourney))
      .value;
});

final etudeBGMPlayerProvider = Provider<AudioPlayer?>((ref) {
  return ref.watch(_audioPlayerFutureProvider(Assets.music.run)).value;
});

final _audioPlayerFutureProvider =
    FutureProvider.family<AudioPlayer, String>((ref, path) async {
  final player = AudioPlayer()..setReleaseMode(ReleaseMode.loop);
  await player.setSource(AssetSource(path.replaceFirst('assets/', '')));

  ref.onDispose(() {
    player.stop();
    player.dispose();
  });

  return player;
});
