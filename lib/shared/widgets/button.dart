import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool outlined;
  final VoidCallback onPressed;
  final IconData icon;
  final bool addIcon;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.outlined,
      this.icon = Icons.add,
      this.addIcon = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: outlined
            ? Theme.of(context).appColors.white100
            : Theme.of(context).appColors.primary,
        padding: EdgeInsets.symmetric(
            horizontal: addIcon ? 12 : 48 , vertical: addIcon ? 8 : 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: BorderSide(
            color: Theme.of(context).appColors.primary,
            width: 0.5,
          ),
        ),
      ),
      // ignore: sized_box_for_whitespace
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addIcon
                ? Container(
                    margin: const EdgeInsets.only(right: 8),
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
    );
  }
}
