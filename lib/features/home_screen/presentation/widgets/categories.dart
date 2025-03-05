import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class Categories extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  const Categories({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4/5,
      child: Container(
        width: 400,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Theme.of(context).appColors.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(
                color: Theme.of(context).appColors.black16, width: 0.5)
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(name,
              style: Theme.of(context)
                  .appTexts
                  .bodyMedium
                  .copyWith(color: Theme.of(context).appColors.black60)),
        ),
      ),
    );
  }
}
