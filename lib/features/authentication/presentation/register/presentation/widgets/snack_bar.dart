import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;

  const CustomSnackBar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: Theme.of(context).appTexts.bodySmall.copyWith(
                  color: Theme.of(context).appColors.red,
                ),
          ),
          backgroundColor: Theme.of(context).appColors.white100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
        ),
      );
    });

    return const SizedBox.shrink();
  }
}
