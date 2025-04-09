import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class NodeWidget extends StatelessWidget {
  final String node;
  final GlobalKey? nodeKey;

  const NodeWidget({super.key, required this.node, this.nodeKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: nodeKey ?? GlobalKey(),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.secondary,
        borderRadius: BorderRadius.circular(32),
        border:
            Border.all(color: Theme.of(context).appColors.secondary, width: 1),
      ),
      child: Text(
        node,
        style: Theme.of(context).appTexts.labelLarge.copyWith(
              color: Theme.of(context).appColors.black87,
              decoration: TextDecoration.none,
            ),
      ),
    );
  }
}
