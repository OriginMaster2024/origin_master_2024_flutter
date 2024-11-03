import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/providers/ingredient_provider.dart';

enum Difficulty {
  easy,
  normal,
  hard,
  ;

  // NOTE: これを変えるとゲームの難易度が変わる
  int get sausageMoveSpeed {
    switch (this) {
      case Difficulty.easy:
        return 70;
      case Difficulty.normal:
        return 100;
      case Difficulty.hard:
        return 200;
    }
  }
}

final difficultyProvider = Provider<Difficulty?>((ref) {
  final bread = ref.watch(breadProvider);
  final sausage = ref.watch(sausageProvider);

  if (bread == null || sausage == null) {
    return null;
  }

  final slippingLevelSum = bread.slippingLevel + sausage.slippingLevel;
  if (slippingLevelSum < 4) {
    return Difficulty.easy;
  } else if (slippingLevelSum < 6) {
    return Difficulty.normal;
  } else {
    return Difficulty.hard;
  }
});