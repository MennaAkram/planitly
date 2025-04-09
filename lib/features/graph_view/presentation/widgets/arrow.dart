import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Graph_View/presentation/cubit/graph_view_operations.dart';

class Arrow extends StatelessWidget {
  final String relation;
  final Directions direction;

  const Arrow({super.key, required this.relation, required this.direction});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: direction == Directions.right || direction == Directions.left
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.rotate(
                  angle: direction == Directions.right ? 0 : 3.14 * -180 / 180,
                  child: SvgPicture.asset(
                    'assets/icons/arrow.svg',
                    width: 48,
                    height: 23,
                  ),
                ),
                Text(relation,
                    style: Theme.of(context).appTexts.labelLarge.copyWith(
                        color: Theme.of(context).appColors.black87,
                        decoration: TextDecoration.none))
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Transform.rotate(
                  angle: direction == Directions.down
                      ? 3.14 * 90 / 180
                      : 3.14 * -90 / 180,
                  child: SvgPicture.asset(
                    'assets/icons/arrow.svg',
                    width: 48,
                    height: 23,
                  ),
                ),
                Text(relation,
                    style: Theme.of(context).appTexts.labelLarge.copyWith(
                        color: Theme.of(context).appColors.black87,
                        decoration: TextDecoration.none))
              ],
            ),
    );
  }
}

