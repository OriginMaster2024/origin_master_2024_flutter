import 'package:flutter/widgets.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';

enum PersonalityType {
  leader,
  freeSpirited,
  seeker,
  revolutionary,
  stabilityOriented,
  ;

  Widget get image {
    return switch (this) {
      PersonalityType.leader => Assets.png.leader.image(),
      PersonalityType.freeSpirited => Assets.png.freeSpirited.image(),
      PersonalityType.seeker => Assets.png.seeker.image(),
      PersonalityType.revolutionary => Assets.png.revolutionary.image(),
      PersonalityType.stabilityOriented => Assets.png.stabilityOriented.image(),
    };
  }

  Widget get titleImage {
    return switch (this) {
      PersonalityType.leader => Assets.png.titlePersonalityLeader.image(),
      PersonalityType.freeSpirited => Assets.png.titlePersonalityFreeSpirited.image(),
      PersonalityType.seeker => Assets.png.titlePersonalitySeeker.image(),
      PersonalityType.revolutionary => Assets.png.titlePersonalityRevolutionary.image(),
      PersonalityType.stabilityOriented => Assets.png.titlePersonalityStabilityOriented.image(),
    };
  }

  static PersonalityType fromString(String type) {
    return switch (type) {
      'リーダー気質' => PersonalityType.leader,
      '自由奔放' => PersonalityType.freeSpirited,
      '探究心' => PersonalityType.seeker,
      '革新的' => PersonalityType.revolutionary,
      '安定志向' => PersonalityType.stabilityOriented,
      String() => throw UnimplementedError(),
    };
  }
}