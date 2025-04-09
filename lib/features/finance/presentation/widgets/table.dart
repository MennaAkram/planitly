import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class FinanceTable extends StatelessWidget {
  final List<Map<String, String>> data;

  const FinanceTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final columnKeys = data.first.keys.toList();
    final columnWidth = MediaQuery.of(context).size.width / columnKeys.length;

    return SingleChildScrollView(
      child: Table(
        columnWidths: {
          for (int i = 0; i < columnKeys.length; i++) i: FixedColumnWidth(columnWidth),
        },
        border: TableBorder.all(color: Theme.of(context).appColors.secondary),
        children: [
          TableRow(
            children: columnKeys.map((key) {
              return _buildCell(context, key, isHeader: true);
            }).toList(),
          ),
          ...data.map((row) {
            return TableRow(
              children: columnKeys.map((key) {
                return _buildCell(context, row[key] ?? "");
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCell(BuildContext context, String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: isHeader
            ? Theme.of(context).appTexts.labelLarge.copyWith(color: Theme.of(context).appColors.black60)
            : Theme.of(context).appTexts.bodyMedium.copyWith(color: Theme.of(context).appColors.black87),
      ),
    );
  }
}