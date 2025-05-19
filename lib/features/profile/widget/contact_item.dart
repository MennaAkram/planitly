// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final String value;

  const ContactItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          alignment: Alignment.centerLeft,
          child: Wrap(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SvgPicture.asset(iconPath),
            ),
            Text(
              title,
              style: Theme.of(context)
                  .appTexts
                  .bodyMedium
                  .copyWith(color: Theme.of(context).appColors.black87),
            )
          ]),
        )),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            value,
            style: Theme.of(context)
                .appTexts
                .bodySmall
                .copyWith(color: Theme.of(context).appColors.black60),
          ),
        )
      ],
    );
  }
}
