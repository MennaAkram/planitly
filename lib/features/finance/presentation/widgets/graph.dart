import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class GraphWidget extends StatefulWidget {
  final List<FlSpot> data;
  final double maxX;
  final double miny;
  final double maxy;
  final bool isIncreasing;
  const GraphWidget({super.key, required this.data, required this.maxX, required this.miny, required this.maxy, required this.isIncreasing});

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16,
          left: 16,
        ),
        child: LineChart(mainData(context)),
      ),
    );
  }

  LineChartData mainData(BuildContext context) {
    return LineChartData(

      lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (spot) => Theme.of(context).appColors.white87,
            tooltipBorder: BorderSide(
              color: Theme.of(context).appColors.black16,
              width: 1,
            ),
            tooltipRoundedRadius: 12,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                return LineTooltipItem(
                  barSpot.y.toString(),
                  Theme.of(context).appTexts.bodySmall.copyWith(
                    color: Theme.of(context).appColors.black87,
                  ),
                );
              }).toList();
            },
          ),
      ),
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      maxX: widget.maxX,
      maxY: widget.maxy,
      minY: widget.miny,
      lineBarsData: [
        LineChartBarData(
          spots: widget.data,
          isCurved: true,
          color: widget.isIncreasing ? Theme.of(context).appColors.green
              : Theme.of(context).appColors.primary,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: widget.isIncreasing ? Theme.of(context).appColors.successGradient
                  : Theme.of(context).appColors.errorGradient,
            ),
          ),
        ),
      ],
    );
  }
}