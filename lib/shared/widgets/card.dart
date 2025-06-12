import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';

class CardWidget extends StatelessWidget {
  final String text;
  final String date;
  final String icon;
  final String type;
  final VoidCallback? onPressed;
  final Color initialsColor;
  final String initials;

  const CardWidget(
      {super.key,
      required this.type,
      required this.text,
      required this.date,
      required this.icon,
      this.onPressed,
      this.initialsColor = Colors.white,
      this.initials = ''
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: type == 'Email'
          ? const EdgeInsets.symmetric(vertical: 12)
          : const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.background,
        borderRadius: BorderRadius.circular(type == 'Email' ? 0 : 24),
        border: type == 'Email'
            ? Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 0.5,
                ),
              )
            : Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 0.5,
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
            type == 'Email'
                ? CircleAvatar(
        radius: 16,
          backgroundColor: initialsColor,
          child: Text(
            initials,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16),
          ),
        )
                : SvgPicture.asset(icon, width: 32, height: 32),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(
                    text,
                    style: Theme.of(context).appTexts.bodySmall.copyWith(
                          color: Theme.of(context).appColors.black60,
                        ),
                  ),
                const SizedBox(height: 8),
                Text(
                  date,
                  style: Theme.of(context).appTexts.bodySmall.copyWith(
                        color: Theme.of(context).appColors.black37,
                      ),
                ),
              ],
            ),
          )
        ],
        ),
      ),
    );
  }
}
