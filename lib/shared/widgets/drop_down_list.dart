import 'package:flutter/material.dart';
import 'package:planitly/design_system/app_colors.dart';
import 'package:planitly/design_system/app_text.dart';

class DropDownList extends StatefulWidget {
  final String hintText;
  final VoidCallback onPressed;
  const DropDownList(
      {super.key, required this.hintText, this.onPressed = _defualtOnPressed});

  static void _defualtOnPressed() {}

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColorsTheme.light().black16, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.hintText,
              style: AppTextsTheme.main().bodyMedium.copyWith(
                    color: AppColorsTheme.light().black87,
                  ),
            ),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColorsTheme.light().black60,
            ),
          ],
        ),
      ),
    );
  }
}
