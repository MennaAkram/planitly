import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';

import '../assets.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool outlined;
  final VoidCallback onPressed;
  final String icon;
  final bool addIcon;
  final double horizontalPadding;
  final double verticalPadding;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.outlined,
      this.horizontalPadding = 48,
      this.verticalPadding = 14,
      this.icon = Assets.iconAdd,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          addIcon
              ? Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 16,
                  height: 16,
                  child: SvgPicture.asset(
                    icon,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).appColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : const SizedBox(),
          Text(
            text,
            style: (Theme.of(context).appTexts.bodySmall).copyWith(
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
