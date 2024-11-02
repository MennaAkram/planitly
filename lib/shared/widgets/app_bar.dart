import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData icon;

  const CustomAppBar(
      {super.key, required this.title, this.icon = Icons.arrow_back_ios_new});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: const EdgeInsets.all(16),
      child: Center(
        child: Row(children: [
          IconButton(
            onPressed: () => {},
            icon: Icon(
              icon,
              color: Theme.of(context).appColors.black87,
              size: 24,
            ),
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
