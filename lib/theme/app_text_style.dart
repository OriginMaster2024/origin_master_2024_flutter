import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  const AppTextStyle._();

  static TextStyle medium({
    Color? color,
    double? fontSize,
  }) {
    return GoogleFonts.notoSansJp(
      fontWeight: FontWeight.w500,
      color: color,
      fontSize: fontSize,
      height: 1.5,
    );
  }

  static TextStyle bold({
    Color? color,
    double? fontSize,
  }) {
    return GoogleFonts.notoSansJp(
      fontWeight: FontWeight.w700,
      color: color,
      fontSize: fontSize,
      height: 1.5,
    );
  }
}
