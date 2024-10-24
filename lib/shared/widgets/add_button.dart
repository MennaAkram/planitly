import 'package:flutter/material.dart';
import 'package:planitly/design_system/app_colors.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColorsTheme.light().primary,
      elevation: 0,
      child: Icon(
        Icons.add,
        color: AppColorsTheme.light().white87,
      ),
    );
  }
}
