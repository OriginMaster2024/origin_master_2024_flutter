import 'package:flutter/material.dart';
import 'package:origin_master_2024_flutter/gen/assets.gen.dart';

enum PersonalityType {
  leader,
  freeSpirited,
  seeker,
  revolutionary,
  stabilityOriented,
}

extension PersonalityTypeExtension on PersonalityType {
  Widget get image {
    return switch (this){
      PersonalityType.leader => Assets.png.leader.image(),
      PersonalityType.freeSpirited => Assets.png.freeSpirited.image(),
      PersonalityType.seeker => Assets.png.seeker.image(),
      PersonalityType.revolutionary => Assets.png.revolutionary.image(),
      PersonalityType.stabilityOriented => Assets.png.stabilityOriented.image(),
    };
  }
}