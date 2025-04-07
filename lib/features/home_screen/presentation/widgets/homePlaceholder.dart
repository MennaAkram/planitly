import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePlaceHolder extends StatelessWidget {

  const HomePlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(32),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.white100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).appColors.black16,
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.homePlaceholder),
          const SizedBox(height: 16),
          Text(
            "Let’s start organizing",
            style: Theme.of(context).appTexts.bodyLarge.copyWith(
                  color: Theme.of(context).appColors.black60,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
