import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/navigator_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String prefixIcon;
  final VoidCallback? onPrefixIconPressed;
  final String? postfixIcon;
  final VoidCallback? onPostfixIconPressed;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.prefixIcon = Assets.iconBackArrow,
      this.onPrefixIconPressed = NavigatorHelper.pop,
      this.postfixIcon,
      this.onPostfixIconPressed});

  @override
  Size get preferredSize => const Size.fromHeight(70.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: onPrefixIconPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              prefixIcon,
              width: 24,
              height: 24,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: Theme.of(context).appTexts.titleSmall.copyWith(
                color: Theme.of(context).appColors.black87,
                decoration: TextDecoration.none,
              ),
        ),
        const Spacer(),
        if (postfixIcon != null)
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: onPostfixIconPressed ?? () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  postfixIcon!,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        const SizedBox(
          width: 8,
        ),
      ]),
    );
  }
}
