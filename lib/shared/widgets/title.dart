import 'package:flutter/material.dart';
import 'package:planitly/design_system/app_colors.dart';
import 'package:planitly/design_system/app_text.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final bool seeAll;
  final VoidCallback onPressed;

  const CustomTitle({
    super.key,
    required this.title,
    this.seeAll = true,
    this.onPressed = _defaultOnPressed,
  });

  static void _defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextsTheme.main().titleSmall,
          ),
          seeAll
              ? InkWell(
                  onTap: onPressed,
                  child: Text(
                    'see all',
                    style: AppTextsTheme.main().labelLarge.copyWith(
                          color: AppColorsTheme.light().black37,
                        ),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
