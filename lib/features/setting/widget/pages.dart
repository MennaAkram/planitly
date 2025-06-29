import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/assets.dart';
class RemovableTag extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const RemovableTag({
    Key? key,
    required this.label,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 62,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).appColors.black16),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onRemove,
            child: SvgPicture.asset(Assets.cancel),
          ),
            const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).appTexts.labelMedium.copyWith(
              color: Theme.of(context).appColors.black87
            ),
          ),
        ],
      ),
    );
  }
}