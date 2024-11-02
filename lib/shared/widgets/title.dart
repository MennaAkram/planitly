import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

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
            style: Theme.of(context).appTexts.titleSmall.copyWith(
                  color: Theme.of(context).appColors.black87,
                ),
          ),
          seeAll
              ? InkWell(
                  onTap: onPressed,
                  child: Text(
                    'see all',
                    style: Theme.of(context).appTexts.labelLarge.copyWith(
                          color: Theme.of(context).appColors.black37,
                        ),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
