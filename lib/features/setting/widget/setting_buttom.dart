import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';

class SettingButtom extends StatelessWidget {
  final String text;
  final String address;
  final String iconPath;
  final VoidCallback? onTap;

  const SettingButtom({
    super.key,
    required this.text,
    required this.iconPath,
    this.onTap,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(iconPath),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: Theme.of(context).appTexts.bodySmall.copyWith(
                      color: Theme.of(context).appColors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: Theme.of(context).appTexts.bodySmall.copyWith(
                      color: Theme.of(context).appColors.black60,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
