import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class most_visited extends StatelessWidget {
  final String name;
  const most_visited({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Theme.of(context).appColors.secondary,
          border: Border.all(
              color: Theme.of(context).appColors.black16, width: 0.5)),
      child: Text(name,
          style: Theme.of(context)
              .appTexts
              .bodyLarge
              .copyWith(color: Theme.of(context).appColors.black87)),
    );
  }
}
