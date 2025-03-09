import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Graph_View/presentation/cubit/graph_view_operations.dart';
import 'package:planitly/features/Graph_View/presentation/widgets/graph_view.dart';
import 'package:planitly/shared/widgets/app_bar.dart';

class GraphViewScreen extends StatelessWidget {
final GraphView graphView;

  const GraphViewScreen({super.key, required this.graphView});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Theme.of(context).appColors.background,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CustomAppBar(title: "Graph View"),
          ),
          Expanded(
            flex: 1,
            child: GraphViewWidget(
                graphNodes: graphView.nodes, scrollable: true, scaleable: true),
          ),
        ],
      ),
    );
  }
}
