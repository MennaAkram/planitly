import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/notifications/presentation/view/notifications_screen.dart';
import 'package:planitly/features/profile/presentation/view/profile_screen.dart';
import '../../../../shared/assets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/navigator_helper.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String imageAssetPath;
  final String name;
  final Function onPressed;

  const HomeAppBar({super.key, required this.imageAssetPath, required this.name, required this.onPressed});
  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Hello, $name",
        style: Theme.of(context)
            .appTexts
            .titleSmall
            .copyWith(color: Theme.of(context).appColors.black87),
      ),
      titleSpacing: 0,
      leading: IconButton(
        onPressed:() {
          NavigatorHelper.push(const ProfileScreen());
        },
        padding: const EdgeInsets.all(0),
        icon: ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(17.5),
            child: Image.asset(imageAssetPath, fit: BoxFit.fitWidth),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).appColors.white100,
      elevation: 0.0,
      actions: [
        IconButton(
          onPressed: () { onPressed(); },
          icon: SvgPicture.asset(Assets.notification),
          color: Theme.of(context).appColors.black60,
        ),
      ],
    );
  }
}
