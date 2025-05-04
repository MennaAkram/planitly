import 'package:planitly/features/finance/domain/data/remote/income_dto.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class IncomeInfoDto extends BaseMapper<IncomeInfoDto> {
  List<IncomeDto>? incomes;

  IncomeInfoDto({
    this.incomes,
  });

  @override
  Map<String, dynamic> toJson(IncomeInfoDto object) {
    return {
      'incomes':
          object.incomes?.map((income) => income.toJson(income)).toList(),
    };
  }

  @override
  IncomeInfoDto fromJson(Map<String, dynamic> json) {
    return IncomeInfoDto(
      incomes: (json['incomes'] as List<dynamic>?)
          ?.map((income) => IncomeDto().fromJson(income))
          .toList(),
    );
  }
}
