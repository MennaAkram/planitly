import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class MyPagesCard extends StatelessWidget {
  final String name;

  const MyPagesCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        ));
  }
}
