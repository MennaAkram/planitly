import 'package:flutter/material.dart';
import 'package:planitly/design_system/app_colors.dart';
import 'package:planitly/design_system/app_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;

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
              Icons.arrow_back_ios_new,
              color: AppColorsTheme.light().black87,
              size: 24,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(title,
              style: AppTextsTheme.main()
                  .titleSmall
                  .copyWith(color: AppColorsTheme.light().black87)),
        ]),
      ),
    );
  }
}
