import 'package:planitly/features/finance/domain/entity/income_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class IncomeDto extends BaseMapper<IncomeDto> {
  String? name;
  double? amount;
  DateTime? date;

  IncomeDto({
    this.name,
    this.amount,
    this.date,
  });

  @override
  Map<String, dynamic> toJson(IncomeDto object) {
    return {
      'name': object.name,
      'amount': object.amount,
      'date': object.date?.toIso8601String(),
    };
  }

  @override
  IncomeDto fromJson(Map<String, dynamic> json) {
    return IncomeDto(
      name: json['name'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }

  List<IncomeDto> toDto(List<dynamic> data) {
    return data.map((e) => IncomeDto().fromJson(e)).toList();
  }

  List<IncomeEntity> toEntityList(List<dynamic> data) {
    return IncomeDto().toDto(data).map((e) => e.toEntity()).toList();
  }

  IncomeEntity toEntity() {
    return IncomeEntity(
      name: name ?? '',
      amount: amount ?? 0.0,
      date: date ?? DateTime.now(),
    );
  }
}
