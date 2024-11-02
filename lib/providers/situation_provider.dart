import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:origin_master_2024_flutter/domain_object/situation.dart';

final situationProvider = Provider<Situation>((ref) {
  return Situation.values[Random().nextInt(Situation.values.length)];
});
