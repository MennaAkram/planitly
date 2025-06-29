import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:planitly/app/di.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/finance/presentation/cubit/finance_cubit.dart';
import 'package:planitly/features/finance/presentation/widgets/date_text_field.dart';
import 'package:planitly/features/finance/presentation/widgets/graph.dart';
import 'package:planitly/generated/l10n.dart';
import 'package:planitly/shared/bases/base_state.dart';
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
  final FinanceCubit _cubit = getIt.get<FinanceCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.getFinance();
  }

  void _addRecord(bool isIncome, Map<String, String> newRecord) {
    if (isIncome) {
      _cubit.addFinanceRecord(
          isIncome: isIncome,
          name: newRecord[AppLocalizations.current.income] ?? '',
          amount: double.tryParse(
                  newRecord[AppLocalizations.current.amount] ?? '0') ??
              0.0,
          date: DateFormat("MMM dd, yyyy")
              .parse(newRecord[AppLocalizations.current.date] ?? ''));
    } else {
      final double expenseAmount =
          double.tryParse(newRecord[AppLocalizations.current.amount] ?? '0') ??
              0.0;
      if (_cubit.hasEnoughAmount(expenseAmount)) {
        _cubit.addFinanceRecord(
            isIncome: isIncome,
            name: newRecord[AppLocalizations.current.expense] ?? '',
            amount: expenseAmount,
            date: DateFormat("MMM dd, yyyy")
                .parse(newRecord[AppLocalizations.current.date] ?? ''));
      } else {
        context.showCustomSnackBar(AppLocalizations.current.amountNotEnough);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.background,
      appBar: CustomAppBar(title: AppLocalizations.current.finance),
      body: BlocListener<FinanceCubit, BaseState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is ErrorState) {
            if (state.msg != "Token has expired") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.msg!,
                      style: Theme.of(context).appTexts.bodySmall.copyWith(
                            color: Theme.of(context).appColors.red,
                          )),
                  backgroundColor: Theme.of(context).appColors.white100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(24),
                ),
              );
            }
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<FinanceCubit, BaseState>(
                bloc: _cubit,
                builder: (context, state) {

                  if (state is LoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context).totalAmount,
                              style: Theme.of(context).appTexts.titleSmall.copyWith(
                                color: Theme.of(context).appColors.black60,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _cubit.totalAmount.toStringAsFixed(2),
                              style: Theme.of(context).appTexts.titleSmall.copyWith(
                                color: Theme.of(context).appColors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GraphWidget(
                        data: _cubit.graphData,
                        maxX: _cubit.graphData.isEmpty
                            ? 1
                            : _cubit.graphData.length - 1,
                        miny: _cubit.minY,
                        maxy: _cubit.maxY,
                        isIncreasing: _cubit.isIncreasing,
                      ),
                    ],
                  );
                },
              ),
              _buildSection(
                title: AppLocalizations.current.incomes,
                isIncome: true,
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
                isIncome: false,
                onAddPressed: () => _openAddRecordDialog(false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required bool isIncome,
    required VoidCallback onAddPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(title, onAddPressed),
        BlocBuilder<FinanceCubit, BaseState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final items = isIncome ? _cubit.incomes : _cubit.expenses;
            if (items.isEmpty) {
              return const SizedBox.shrink();
            }

            return FinanceTable(
              data: items,
              isIncome: isIncome,
            );
          },
        ),
        SizedBox(height: 24),
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
            text:
                "${AppLocalizations.current.addNew} ${title.toLowerCase().substring(0, title.length - 1)}",
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
      isIncome
          ? AppLocalizations.current.addIncome
          : AppLocalizations.current.addExpense,
      AppLocalizations.current.add,
      AppLocalizations.current.cancel,
      () {
        if (formKey.currentState?.validate() ?? false) {
          final Map<String, String> newRecord = {
            isIncome
                ? AppLocalizations.current.income
                : AppLocalizations.current.expense: nameController.text,
            AppLocalizations.current.amount: amountController.text,
            AppLocalizations.current.date: dateController.text,
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
              labelText: isIncome
                  ? AppLocalizations.current.incomeName
                  : AppLocalizations.current.expenseName,
              controller: nameController,
              validator: (value) => Validators.cantBeEmpty(value),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: isIncome
                  ? AppLocalizations.current.incomeAmount
                  : AppLocalizations.current.expenseAmount,
              controller: amountController,
              validator: (value) => Validators.numericalFieldValidator(value),
            ),
            const SizedBox(height: 16),
            DateTextField(
              labelText: isIncome
                  ? AppLocalizations.current.incomeDate
                  : AppLocalizations.current.expenseDate,
              controller: dateController,
              validator: (value) => Validators.cantBeEmpty(value),
            ),
          ],
        ),
      ),
    );
  }
}
