import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Expenses extends StatelessWidget {
  final String name;
  final String value;
  final bool state;

  const Expenses({
    super.key,
    required this.name,
    required this.value,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Card(
        elevation: 0,
        color: Theme.of(context).appColors.purple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text(
            name,
            style: Theme.of(context).appTexts.bodyLarge.copyWith(
                  color: Theme.of(context).appColors.white100,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: Theme.of(context).appTexts.bodySmall.copyWith(
                      color: Theme.of(context).appColors.white100,
                    ),
              ),
              const SizedBox(width: 8),
              state == false
                  ? SvgPicture.asset(Assets.arrow_down)
                  : SvgPicture.asset(Assets.arrow_up),
            ])
          ]),
        ),
    );
  }
}
