import 'package:planitly/shared/bases/base_mapper.dart';

class ExpenseDto extends BaseMapper<ExpenseDto> {
  String? name;
  double? amount;
  DateTime? date;

  ExpenseDto({this.name, this.amount, this.date});

  @override
  Map<String, dynamic> toJson(ExpenseDto object) {
    return {
      'name': object.name,
      'amount': object.amount,
      'date': object.date?.toIso8601String(),
    };
  }

  @override
  ExpenseDto fromJson(Map<String, dynamic> json) {
    return ExpenseDto(
      name: json['name'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }
}
