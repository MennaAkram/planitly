import 'package:planitly/features/finance/domain/data/remote/expense_dto.dart';
import 'package:planitly/features/finance/domain/entity/expense_info_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class ExpenseInfoDto extends BaseMapper<ExpenseInfoDto> {
  List<ExpenseDto>? expenseList;

  ExpenseInfoDto({
    this.expenseList,
  });

  @override
  Map<String, dynamic> toJson(ExpenseInfoDto object) {
    return {
      'expenseList': object.expenseList?.map((e) => e.toJson(e)).toList(),
    };
  }

  @override
  ExpenseInfoDto fromJson(Map<String, dynamic> json) {
    return ExpenseInfoDto(
      expenseList: (json['expenseList'] as List<dynamic>?)
          ?.map((expense) => ExpenseDto().fromJson(expense))
          .toList(),
    );
  }

  ExpenseInfoEntity toEntity() {
    return ExpenseInfoEntity(
      expenseList: expenseList!.map((expense) => expense.toEntity()).toList(),
    );
  }
}
