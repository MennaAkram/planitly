import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class ProfileButtonCard extends StatelessWidget {
  final String text;
  final Color? textColor;
  final VoidCallback? onTap;

  const ProfileButtonCard({
    super.key,
    required this.text,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      width: double.infinity,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          backgroundColor: Theme.of(context).appColors.white100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Theme.of(context).appColors.black16),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(text,
              style: Theme.of(context).appTexts.bodyMedium.copyWith(
                  color: textColor ?? Theme.of(context).appColors.black87)),
        ),
      ),
    );
  }
}
