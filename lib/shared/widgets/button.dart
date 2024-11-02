import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool outlined;
  final VoidCallback onPressed;
  final double horizontalPadding;
  final double verticalPadding;
  final IconData icon;
  final bool addIcon;
  final double width;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.outlined,
      this.horizontalPadding = 48,
      this.verticalPadding = 14,
      this.icon = Icons.add,
      this.addIcon = false,
      this.width = 100});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: outlined
            ? Theme.of(context).appColors.white100
            : Theme.of(context).appColors.primary,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: BorderSide(
            color: Theme.of(context).appColors.primary,
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
                      icon,
                      color: Theme.of(context).appColors.primary,
                      size: 16,
                    ),
                  )
                : const SizedBox(),
            Text(
              text,
              style: (addIcon
                      ? Theme.of(context).appTexts.bodySmall
                      : Theme.of(context).appTexts.titleSmall)
                  .copyWith(
                color: outlined
                    ? Theme.of(context).appColors.primary
                    : Theme.of(context).appColors.white100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
