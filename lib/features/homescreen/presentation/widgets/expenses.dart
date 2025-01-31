import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/assests.dart';
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
    return SizedBox(
      height: 84,
      width: 150,
      child: Card(
        color: Theme.of(context).appColors.purple,
        child: ListTile(
          title: Text(
            name,
            style: Theme.of(context).appTexts.bodyLarge.copyWith(
                  color: Theme.of(context).appColors.white100,
                ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: Theme.of(context).appTexts.bodySmall.copyWith(
                      color: Theme.of(context).appColors.white100,
                    ),
              ),
              state == false
                  ? SvgPicture.asset(Assests.arrow_down)
                  : SvgPicture.asset(Assests.arrow_up),
            ],
          ),
        ),
      ),
    );
  }
}
