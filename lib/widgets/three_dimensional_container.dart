import 'package:flutter/material.dart';

class ThreeDimensionalContainer extends StatelessWidget {
  final Widget? child;
  final Color backgroundColor;
  final Color shadowColor;
  final double shadowOffsetY = 1;

  const ThreeDimensionalContainer({
    super.key,
    required this.child,
    this.backgroundColor = const Color(0xFFFFF6E1),
    this.shadowColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(width: 2, color: shadowColor),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: Offset(0, shadowOffsetY),
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: child,
      ),
    );
  }
}
