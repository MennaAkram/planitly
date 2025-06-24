import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/assets.dart';

class SelectedPage extends StatelessWidget {
  final String itemName;
  final VoidCallback? onRemove;

  const SelectedPage({super.key, required this.itemName, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).appColors.background,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Theme.of(context).appColors.black16,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: onRemove,
              child: SvgPicture.asset(
                Assets.cancel,
                width: 6,
                height: 6,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                itemName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).appTexts.labelMedium.copyWith(
                      color: Theme.of(context).appColors.black87,
                    ),
              ),
            ),
          ],
        ));
  }
}
