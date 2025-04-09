import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class CustomDialogButton extends StatelessWidget {
  final String text;
  final bool outlined;
  final VoidCallback onPressed;

  const CustomDialogButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.outlined,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: outlined
            ? Theme.of(context).appColors.white100
            : Theme.of(context).appColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: BorderSide(
            color: Theme.of(context).appColors.primary,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).appTexts.titleSmall.copyWith(
                  color: outlined
                      ? Theme.of(context).appColors.primary
                      : Theme.of(context).appColors.white100,
                ),
          ),
        ],
      ),
    );
  }
}
