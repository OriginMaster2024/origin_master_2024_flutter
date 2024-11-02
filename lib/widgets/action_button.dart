import 'package:flutter/material.dart';
import 'package:origin_master_2024_flutter/widgets/three_dimensional_button.dart';
import 'package:origin_master_2024_flutter/theme/app_text_style.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ThreeDimensionalButton(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).primaryColor,
      child: SizedBox(
        height: 48,
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.bold(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
