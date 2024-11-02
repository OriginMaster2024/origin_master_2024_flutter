import 'package:flutter/material.dart';

class DeviceSize {
  static Size size = const Size(0, 0);
  static double width = 0;
  static double height = 0;

  static void ensureInitialized(BuildContext context) {
    size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
  }
}