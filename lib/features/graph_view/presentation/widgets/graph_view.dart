import 'package:flutter/material.dart';
import 'package:planitly/features/graph_view/presentation/cubit/graph_view_operations.dart';
import 'package:planitly/features/graph_view/presentation/widgets/arrow.dart';
import 'package:planitly/features/graph_view/presentation/widgets/node.dart';

class GraphViewWidget extends StatefulWidget {
  final List<Node> graphNodes;
  final bool scrollable;
  final bool scaleable;

  const GraphViewWidget(
      {super.key,
      required this.graphNodes,
      required this.scrollable,
      required this.scaleable});

  @override
  State<GraphViewWidget> createState() => _GraphViewWidgetState();
}

class _GraphViewWidgetState extends State<GraphViewWidget> {
  late List<Node> _graphNodes;

  @override
  void initState() {
    _graphNodes = widget.graphNodes;
    _placeWidgets();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GraphViewWidget oldWidget) {
    _graphNodes = widget.graphNodes;
    _placeWidgets();
    super.didUpdateWidget(oldWidget);
  }

  void _placeWidgets() {
    if (_graphNodes.any((node) => node.size == const Size(0, 0))) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _calcSize();
        _calcOffset();
        setState(() {});
      });
    } else {
      _calcOffset();
    }
  }

  void _calcSize() {
    for (Node node in _graphNodes) {
      node.size = node.key.currentContext!.size!;
      for (var relation in node.relations.entries) {
        if (relation.value?.nextNodeIndex != -1) {
          _graphNodes[relation.value!.nextNodeIndex].size =
              _graphNodes[relation.value!.nextNodeIndex]
                  .key
                  .currentContext!
                  .size!;
        }
      }
    }
  }

  void _calcOffset() {
    double nodeSpacing = 70.0;

    for (Node node in _graphNodes) {
      Size nodeSize = node.size;
      Offset nodeOffset = node.position;

      for (var relation in node.relations.entries) {
        var relationValue = relation.value;
        if (relationValue != null &&
            relationValue.nextNodeIndex != -1 &&
            relationValue.position == Offset.zero) {
          Node nextNode = _graphNodes[relationValue.nextNodeIndex];
          Size nextNodeSize = nextNode.size;

          switch (relation.key) {
            case Directions.right:
              relationValue.position = Offset(
                  nodeOffset.dx + nodeSize.width + ((nodeSpacing - 48) / 2),
                  nodeOffset.dy + (nodeSize.height / 2) - (23 / 2));

              nextNode.position = Offset(
                  nodeOffset.dx + nodeSize.width + nodeSpacing, nodeOffset.dy);
              break;
            case Directions.down:
              relationValue.position = Offset(
                  nodeOffset.dx + (nodeSize.width / 2) > nodeOffset.dx + 48 / 2
                      ? nodeOffset.dx + (nodeSize.width / 2 - 48 / 2).abs()
                      : nodeOffset.dx - (nodeSize.width - 48).abs() / 2,
                  nodeOffset.dy +
                      (nodeSize.height - 48).abs() * 2 +
                      53 +
                      (nodeSpacing - 48) / 2);

              nextNode.position = Offset(
                  nodeOffset.dx + (nodeSize.width / 2) <
                          nodeOffset.dx + (nextNodeSize.width / 2)
                      ? nodeOffset.dx -
                          (nodeSize.width / 2 - nextNodeSize.width / 2).abs()
                      : nodeOffset.dx +
                          (nodeSize.width / 2 - nextNodeSize.width / 2).abs(),
                  nodeOffset.dy + nodeSize.height + nodeSpacing);
              break;
            case Directions.left:
              relationValue.position = Offset(
                  nodeOffset.dx - 48 - ((nodeSpacing - 48) / 2) - 5,
                  nodeOffset.dy + (nodeSize.height - 23) / 2);

              nextNode.position = Offset(
                  nodeOffset.dx - nextNodeSize.width - nodeSpacing,
                  nodeOffset.dy);
              break;
            case Directions.up:
              relationValue.position = Offset(
                  nodeOffset.dx + (nodeSize.width / 2) > nodeOffset.dx + 48 / 2
                      ? nodeOffset.dx + (nodeSize.width / 2 - 48 / 2).abs()
                      : nodeOffset.dx - (nodeSize.width - 48).abs() / 2,
                  nodeOffset.dy - (nodeSize.height - 48).abs() / 2 - 48);

              nextNode.position = Offset(
                  nodeOffset.dx + (nodeSize.width / 2) <
                          nodeOffset.dx + (nextNodeSize.width / 2)
                      ? nodeOffset.dx -
                          (nodeSize.width / 2 - nextNodeSize.width / 2).abs()
                      : nodeOffset.dx +
                          (nodeSize.width / 2 - nextNodeSize.width / 2).abs(),
                  nodeOffset.dy - nextNodeSize.height - nodeSpacing);
              break;
          }
        }
      }
    }
  }

  List<Positioned> _children() {
    List<Positioned> children = [];
    for (var node in _graphNodes) {
      children.add(Positioned(
        left: node.position.dx,
        top: node.position.dy,
        child: NodeWidget(
          nodeKey: node.key,
          node: node.name,
        ),
      ));
      for (var relation in node.relations.entries) {
        if (relation.value != null && relation.value!.nextNodeIndex != -1) {
          children.add(Positioned(
            left: relation.value!.position.dx,
            top: relation.value!.position.dy,
            child: Arrow(
              direction: relation.key,
              relation: relation.value!.relation,
            ),
          ));
        }
      }
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(widget.scrollable ? 1000 : 0),
          trackpadScrollCausesScale: true,
          scaleEnabled: widget.scaleable,
          child: Container(
            width: 1000,
            height: 1000,
            clipBehavior: Clip.none,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              clipBehavior: Clip.none,
              children: _children(),
            ),
          )),
    );
  }
}
