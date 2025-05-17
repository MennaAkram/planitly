import 'package:planitly/features/finance/data/remote/finance_table_dto.dart';
import 'package:planitly/features/finance/domain/entity/finance_info_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class FinanceInfoDto extends BaseMapper<FinanceInfoDto> {
  FinanceTableDto? incomeInfo;
  FinanceTableDto? expenseInfo;

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
      incomeInfo: FinanceTableDto().fromJson(json['components'][0]),
      expenseInfo: FinanceTableDto().fromJson(json['components'][1]),
    );
  }

  FinanceInfoEntity toEntity() {
    return FinanceInfoEntity(
      incomeInfo: incomeInfo!.toEntity(),
      expenseInfo: expenseInfo!.toEntity(),
    );
  }
}
