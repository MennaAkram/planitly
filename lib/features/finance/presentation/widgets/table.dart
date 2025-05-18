import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/finance/domain/entity/finance_record_entity.dart';
import 'package:planitly/generated/l10n.dart';

class FinanceTable extends StatelessWidget {
  final List<FinanceRecordEntity> data;
  final bool isIncome;

  const FinanceTable({super.key, required this.data, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    final List<String> columnKeys = [
      AppLocalizations.current.date,
      AppLocalizations.current.amount
    ];
    columnKeys.insert(
        0,
        isIncome
            ? AppLocalizations.current.income
            : AppLocalizations.current.expense);
    final columnWidth = MediaQuery.of(context).size.width / columnKeys.length;

    return SingleChildScrollView(
      child: Table(
        columnWidths: {
          for (int i = 0; i < columnKeys.length; i++)
            i: FixedColumnWidth(columnWidth),
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
              children: [
                _buildCell(context, row.name),
                _buildCell(context, row.amount.toString()),
                _buildCell(context, DateFormat("MMM dd, yyyy").format(row.date))
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCell(BuildContext context, String text,
      {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: isHeader
            ? Theme.of(context)
                .appTexts
                .labelLarge
                .copyWith(color: Theme.of(context).appColors.black60)
            : Theme.of(context)
                .appTexts
                .bodyMedium
                .copyWith(color: Theme.of(context).appColors.black87),
      ),
    );
  }
}
