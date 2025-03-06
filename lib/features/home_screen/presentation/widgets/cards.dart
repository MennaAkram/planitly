import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class MyCards extends StatelessWidget {
  final String imageAssetPath;
  final String name;
  final Function onPressed;

  const MyCards({
    super.key,
    required this.imageAssetPath,
    required this.name,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
          onTap: () => onPressed(),
          child: Card(
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            color: Theme.of(context).appColors.white100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Theme.of(context).appColors.black16,
                width: 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    imageAssetPath,
                    height: 50,
                  ),
                  Text(
                    name,
                    style: Theme.of(context).appTexts.labelMedium.copyWith(
                          color: Theme.of(context).appColors.black87,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}