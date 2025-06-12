import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData icon;

  const CustomAppBar(
      {super.key, required this.title, this.icon = Icons.arrow_back_ios_new});

  @override
  Size get preferredSize => const Size.fromHeight(70.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Center(
        child: Row(children: [
          IconButton(
            onPressed: () => { Navigator.pop(context) },
            icon: Icon(
              icon,
              color: Theme.of(context).appColors.black87,
              size: 24,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).appTexts.titleSmall.copyWith(
                    color: Theme.of(context).appColors.black87,
                    decoration: TextDecoration.none,
                  ),
            ),
          ),
        ]),
      ),
    );
  }
}
