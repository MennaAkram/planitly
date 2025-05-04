import 'package:planitly/features/finance/domain/data/remote/expense_info_dto.dart';
import 'package:planitly/features/finance/domain/data/remote/income_info_dto.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class FinanceInfoDto extends BaseMapper<FinanceInfoDto> {
  IncomeInfoDto? incomeInfo;
  ExpenseInfoDto? expenseInfo;

  FinanceInfoDto({
    this.incomeInfo,
    this.expenseInfo,
  });

  @override
  Map<String, dynamic> toJson(FinanceInfoDto object) {
    return {
      'incomeInfo': object.incomeInfo?.toJson(object.incomeInfo!),
      'expenseInfo': object.expenseInfo?.toJson(object.expenseInfo!),
    };
  }

  @override
  FinanceInfoDto fromJson(Map<String, dynamic> json) {
    return FinanceInfoDto(
      incomeInfo: IncomeInfoDto().fromJson(json['incomeInfo']),
      expenseInfo: ExpenseInfoDto().fromJson(json['expenseInfo']),
    );
  }
}
