import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Notifications/presentation/cubit/notifications_operations.dart';

class CardWidget extends StatelessWidget {
  final Notify notification;

  const CardWidget({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 0.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            notification.icon,
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
                    notification.text,     
                    style: Theme.of(context).appTexts.bodySmall.copyWith(
                          color: Theme.of(context).appColors.black60,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  notification.getDate(),
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
