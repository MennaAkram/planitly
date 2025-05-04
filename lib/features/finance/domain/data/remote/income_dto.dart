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
}
