import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class PieChartSample extends StatefulWidget {
  final bool isPieChart;
  final List<num> data;

  const PieChartSample({
    super.key,
    required this.isPieChart,
    required this.data,
  });

  @override
  State<PieChartSample> createState() => _PieChartState();
}

class _PieChartState extends State<PieChartSample> {
  int touchedIndex = -1;
  bool get isPieChart => widget.isPieChart;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: isPieChart ? 1.4 : 1.4,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = pieTouchResponse
                          .touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: isPieChart ? 0 : 60,
                sections: showingSections(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final sortedData = widget.data.asMap().entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return List.generate(widget.data.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 24.0 : 16.0;
      final radius = isTouched ? (isPieChart ? 120.0 : 60.0) : (isPieChart ? 110.0 : 50.0);
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      final color = _getColor(sortedData.indexWhere((entry) => entry.key == i));

      return PieChartSectionData(
        color: color,
        value: widget.data[i].toDouble(),
        title: '${widget.data[i]}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).appColors.white100,
          shadows: shadows,
        ),
      );
    });
  }

  Color _getColor(int index) {
    final colors = [
      Theme.of(context).appColors.red,
      Theme.of(context).appColors.primary,
      Theme.of(context).appColors.blue,
      Theme.of(context).appColors.purple,
      Theme.of(context).appColors.green,
      Theme.of(context).appColors.black60,
      Theme.of(context).appColors.black16,
    ];
    return colors[index % colors.length];
  }
}