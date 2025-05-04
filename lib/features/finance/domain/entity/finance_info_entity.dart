import 'package:planitly/features/finance/domain/entity/expense_info_entity.dart';
import 'package:planitly/features/finance/domain/entity/income_info_entity.dart';

class FinanceInfoEntity {
  final IncomeInfoEntity incomeInfo;
  final ExpenseInfoEntity expenseInfo;

  FinanceInfoEntity({
    required this.incomeInfo,
    required this.expenseInfo,
  });
}
