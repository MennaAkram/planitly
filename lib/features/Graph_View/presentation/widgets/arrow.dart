import 'package:flutter/material.dart';
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
                  child: ClipPath(
                    clipper: _CustomClipper(),
                    child: Container(
                      width: 48,
                      height: 23,
                      decoration: BoxDecoration(
                        gradient: Theme.of(context).appColors.gradientLR,
                      ),
                    ),
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
                  child: ClipPath(
                    clipper: _CustomClipper(),
                    child: Container(
                      width: 48,
                      height: 23,
                      decoration: BoxDecoration(
                        gradient: Theme.of(context).appColors.gradientLR,
                      ),
                    ),
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

class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.4);
    path.lineTo(size.width * 0.875, size.height * 0.4);
    path.lineTo(size.width * 0.75, size.height * 0.18);
    path.quadraticBezierTo(size.width * 0.65, 0, size.width * 0.75, 0);
    path.lineTo(size.width * 0.95, size.height * 0.4);
    path.quadraticBezierTo(
        size.width, size.height * 0.5, size.width * 0.95, size.height * 0.6);
    path.lineTo(size.width * 0.95, size.height * 0.6);
    path.lineTo(size.width * 0.75, size.height);
    path.quadraticBezierTo(
        size.width * 0.65, size.height, size.width * 0.75, size.height * 0.82);
    path.lineTo(size.width * 0.875, size.height * 0.6);
    path.lineTo(0, size.height * 0.6);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
