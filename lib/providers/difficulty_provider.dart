import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/providers/ingredient_provider.dart';

enum Difficulty {
  easy,
  normal,
  hard
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