import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class CustomSwitch extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CustomSwitch(
      {super.key, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeOutBack,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          color: Theme.of(context).appColors.white100,
          border: Border(
            left: BorderSide(
              color: Theme.of(context).appColors.secondary,
              width: 1,
            ),
            bottom: isSelected? BorderSide(
              color: Theme.of(context).appColors.primary,
              width: 1,
            ): BorderSide(
              color: Theme.of(context).appColors.secondary,
              width: 1,
            ),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).appTexts.labelLarge.copyWith(
                  color: Theme.of(context).appColors.black60,
                ),
          ),
        ),
      ),
    );
  }
}
