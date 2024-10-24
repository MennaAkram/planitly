import 'package:flutter/material.dart';
import 'package:planitly/design_system/app_colors.dart';
import 'package:planitly/design_system/app_text.dart';
// import 'package:planitly/design_system/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool outlined;
  final VoidCallback onPressed;
  final double horizontalPadding;
  final double verticalPadding;
  final bool addIcon;
  final double? width;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.outlined,
      this.horizontalPadding = 48,
      this.verticalPadding = 14,
      this.addIcon = false,
      this.width = 100});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: outlined
            ? AppColorsTheme.light().white100
            : AppColorsTheme.light().primary,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: BorderSide(
            color: AppColorsTheme.light().primary,
            width: 0.5,
          ),
        ),
      ),
      // ignore: sized_box_for_whitespace
      child: Container(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addIcon
                ? Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.add,
                      color: AppColorsTheme.light().primary,
                      size: 16,
                    ),
                  )
                : const SizedBox(),
            Text(
              text,
              style: addIcon
                  ? AppTextsTheme.main().bodySmall.copyWith(
                        color: outlined
                            ? AppColorsTheme.light().primary
                            : AppColorsTheme.light().white100,
                      )
                  : AppTextsTheme.main().titleSmall.copyWith(
                        color: outlined
                            ? AppColorsTheme.light().primary
                            : AppColorsTheme.light().white100,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
