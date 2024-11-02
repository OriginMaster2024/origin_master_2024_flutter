import 'package:flutter/material.dart';
import 'package:origin_master_2024_flutter/widgets/three_dimensional_button.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ThreeDimensionalButton(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).primaryColor,
      child: SizedBox(
        height: 48,
        child: child,
      ),
    );
  }
}
