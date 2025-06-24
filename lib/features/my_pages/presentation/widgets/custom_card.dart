import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class CustomCard extends StatelessWidget {
  final String name;
  final VoidCallback? onClick;

  const CustomCard({super.key, required this.name, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).appColors.secondary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).appColors.black16,
              width: 0.5,
            ),
          ),
          child: Center(
            child: Text(name,
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).appTexts.bodyMedium.copyWith(
                      color: Theme.of(context).appColors.black60,
                    )),
          )),
    );
  }
}
