import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/finance/presentation/widgets/date_text_field.dart';
import 'package:planitly/features/finance/presentation/widgets/graph.dart';
import 'package:planitly/generated/l10n.dart';
import 'package:planitly/shared/validators.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:planitly/shared/widgets/extensions.dart';
import 'package:planitly/shared/widgets/text_field.dart';
import '../widgets/table.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final List<Map<String, String>> _incomeData = [];
  final List<Map<String, String>> _expenseData = [];
  List<FlSpot> _graphData = [const FlSpot(0, 0), const FlSpot(1, 0)];
  double _maxY = 10;
  bool get _showIncomeTable => _incomeData.isNotEmpty;
  bool get _showExpenseTable => _expenseData.isNotEmpty;
  bool isIncreasing = false;

  @override
  void initState() {
    super.initState();
    _updateGraphData(isIncreasing);
  }

  void _addRecord(bool isIncome, Map<String, String> newRecord) {
    setState(() {
      if (isIncome) {
        _incomeData.add(newRecord);
        _incomeData.sort((a, b) {
          final dateA = DateFormat("MMM dd, yyyy").parse(a[AppLocalizations.current.date] ?? '');
          final dateB = DateFormat("MMM dd, yyyy").parse(b[AppLocalizations.current.date] ?? '');
          return dateA.compareTo(dateB);
        });
      } else {
        final expenseAmount = double.tryParse(newRecord[AppLocalizations.current.amount] ?? '0') ?? 0;
        double totalAmount = 0;

        for (var record in _incomeData) {
          totalAmount += double.tryParse(record[AppLocalizations.current.amount] ?? '0') ?? 0;
        }
        for (var record in _expenseData) {
          totalAmount -= double.tryParse(record[AppLocalizations.current.amount] ?? '0') ?? 0;
        }

        if (totalAmount - expenseAmount < 0) {
          context.showCustomSnackBar(AppLocalizations.current.amountNotEnough);
          return;
        }
        _expenseData.add(newRecord);
        _expenseData.sort((a, b) {
          final dateA = DateFormat("MMM dd, yyyy").parse(a[AppLocalizations.current.date] ?? '');
          final dateB = DateFormat("MMM dd, yyyy").parse(b[AppLocalizations.current.date] ?? '');
          return dateA.compareTo(dateB);
        });
      }

      _updateGraphData(isIncome);
    });
  }

  void _updateGraphData(bool isIncome) {
    double lastTotalAmount = _graphData.isNotEmpty ? _graphData.last.y : 0;

    if (_incomeData.isEmpty && _expenseData.isEmpty) {
      setState(() {
        _graphData = [const FlSpot(0, 0), const FlSpot(1, 0)];
      });
      return;
    }

    if (isIncome) {
      final lastIncome = double.tryParse(_incomeData.last[AppLocalizations.current.amount] ?? '0') ?? 0;
      lastTotalAmount += lastIncome;
    } else {
      final lastExpense = double.tryParse(_expenseData.last[AppLocalizations.current.amount] ?? '0') ?? 0;
      lastTotalAmount -= lastExpense;
    }

    setState(() {
      _graphData.add(FlSpot(_graphData.length.toDouble(), lastTotalAmount));

      _maxY = _graphData.map((e) => e.y.abs()).reduce((a, b) => a > b ? a : b) * 1.2;
      _maxY = _maxY < 10 ? 10 : _maxY;

      isIncreasing = _graphData.length > 1 &&
          _graphData.last.y > _graphData[_graphData.length - 2].y;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.background,
      appBar: CustomAppBar(title: AppLocalizations.current.finance),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GraphWidget(
              data: _graphData,
              maxX: _graphData.isEmpty ? 1 : _graphData.length - 1,
              maxy: _maxY,
              isIncreasing: isIncreasing,
            ),
            _buildSection(
              title: AppLocalizations.current.incomes,
              showTable: _showIncomeTable,
              data: _incomeData,
              onAddPressed: () => _openAddRecordDialog(true),
            ),
            Divider(
              height: 0.5,
              color: Theme.of(context).appColors.secondary,
              indent: 16,
              endIndent: 16,
            ),
            _buildSection(
              title: AppLocalizations.current.expenses,
              showTable: _showExpenseTable,
              data: _expenseData,
              onAddPressed: () => _openAddRecordDialog(false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required bool showTable,
    required List<Map<String, String>> data,
    required VoidCallback onAddPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(title, onAddPressed),
        if (showTable) FinanceTable(data: data),
        if (showTable) const SizedBox(height: 24) else const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildHeader(String title, VoidCallback onAddPressed) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).appTexts.titleSmall.copyWith(
              color: Theme.of(context).appColors.black87,
            ),
          ),
          CustomButton(
            horizontalPadding: 12,
            verticalPadding: 0,
            text: "${AppLocalizations.current.addNew} ${title.toLowerCase().substring(0, title.length - 1)}",
            onPressed: onAddPressed,
            outlined: true,
            addIcon: true,
          ),
        ],
      ),
    );
  }

  void _openAddRecordDialog(bool isIncome) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    final dateController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    context.alertDialog(
      isIncome ? AppLocalizations.current.addIncome : AppLocalizations.current.addExpense,
      AppLocalizations.current.add,
      AppLocalizations.current.cancel,
          () {
            if (formKey.currentState?.validate() ?? false) {
        final newRecord = {
          isIncome ? AppLocalizations.current.income : AppLocalizations.current.expense: nameController.text,
          AppLocalizations.current.amount : amountController.text,
          AppLocalizations.current.date : dateController.text,
        };
        _addRecord(isIncome, newRecord);
        Navigator.of(context).pop();
            }
      },
          () => Navigator.of(context).pop(),
      Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              labelText: isIncome ? AppLocalizations.current.incomeName : AppLocalizations.current.expenseName,
              controller: nameController,
              validator: (value) => Validators.cantBeEmpty(value),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: isIncome ? AppLocalizations.current.incomeAmount : AppLocalizations.current.expenseAmount,
              controller: amountController,
              validator:(value) => Validators.numericalFieldValidator(value),
            ),
            const SizedBox(height: 16),
            DateTextField(
              labelText: isIncome ? AppLocalizations.current.incomeDate : AppLocalizations.current.expenseDate,
              controller: dateController,
              validator: (value) => Validators.cantBeEmpty(value),
            ),
          ],
        ),
      ),
    );
  }
}