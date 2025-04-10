import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/emails/presentation/cubit/email_operations.dart';

class CardWidget extends StatelessWidget {
  final String text;
  final String date;
  final String icon;
  final Type type;

  const CardWidget(
      {super.key,
      required this.type,
      required this.text,
      required this.date,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: type == Email
          ? const EdgeInsets.symmetric(vertical: 12)
          : const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.background,
        borderRadius: BorderRadius.circular(type == Email ? 0 : 24),
        border: type == Email
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
          SvgPicture.asset(
            icon,
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 226,
                  child: Text(
                    text,
                    style: Theme.of(context).appTexts.bodySmall.copyWith(
                          color: Theme.of(context).appColors.black60,
                        ),
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
    );
  }
}
