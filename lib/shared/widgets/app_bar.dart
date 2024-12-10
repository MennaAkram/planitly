import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';

import '../assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, required this.title, this.icon = Assets.iconBackArrow});

  final String title;
  final String icon;

  @override
  Size get preferredSize => const Size.fromHeight(70.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.all(16),
      child: Center(
        child: Row(children: [
          IconButton(
            iconSize: 24,
            icon: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                Theme.of(context).appColors.black87,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () => {},
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: Theme.of(context).appTexts.titleSmall.copyWith(
                  color: Theme.of(context).appColors.black87,
                ),
          ),
        ]),
      ),
    );
  }
}
