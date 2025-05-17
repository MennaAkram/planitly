import 'package:planitly/features/finance/domain/entity/finance_table_entity.dart';

class FinanceInfoEntity {
  final FinanceTableEntity incomeInfo;
  final FinanceTableEntity expenseInfo;

  FinanceInfoEntity({
    required this.incomeInfo,
    required this.expenseInfo,
  });
}
