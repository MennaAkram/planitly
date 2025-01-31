import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class MyCards extends StatelessWidget {
  final String imageAssetPath;
  final String name;
  final VoidCallback onPressed;

  const MyCards({
    super.key,
    required this.imageAssetPath,
    required this.name,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.white100,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border:
            Border.all(color: Theme.of(context).appColors.black16, width: 0.5),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imageAssetPath,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
            Text(
              name,
              style: Theme.of(context).appTexts.labelMedium.copyWith(
                    color: Theme.of(context).appColors.black87,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
