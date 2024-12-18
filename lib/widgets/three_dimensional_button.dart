import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThreeDimensionalButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color backgroundColor;
  final Color shadowColor;

  const ThreeDimensionalButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.white,
    this.shadowColor = Colors.black,
  });

  @override
  State<ThreeDimensionalButton> createState() => _ThreeDimensionalButtonState();
}

class _ThreeDimensionalButtonState extends State<ThreeDimensionalButton> {
  bool isHighlighted = false;

  double get topPadding => isHighlighted ? 2 : 0;
  double get bottomPadding => isHighlighted ? 0 : 2;
  double get shadowOffsetY => isHighlighted ? 0 : 2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onPressed != null
          ? (_) {
              HapticFeedback.mediumImpact();
              setState(() {
                isHighlighted = true;
              });
            }
          : null,
      onTapCancel: widget.onPressed != null
          ? () {
              setState(() {
                isHighlighted = false;
              });
            }
          : null,
      onTapUp: widget.onPressed != null
          ? (_) {
              setState(() {
                isHighlighted = false;
              });
            }
          : null,
      onTap: widget.onPressed?.call,
      child: Opacity(
        opacity: widget.onPressed != null ? 1 : 0.5,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
          child: Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              border: Border.all(width: 2, color: widget.shadowColor),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: widget.shadowColor,
                  offset: Offset(0, shadowOffsetY),
                  blurRadius: 0,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
