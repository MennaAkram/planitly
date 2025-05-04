import 'package:planitly/features/finance/domain/entity/expense_entity.dart';
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

  List<ExpenseDto> toDto(List<dynamic> data) {
    return data.map((e) => ExpenseDto().fromJson(e)).toList();
  }

  List<ExpenseEntity> toEntityList(List<dynamic> data) {
    return ExpenseDto().toDto(data).map((e) => e.toEntity()).toList();
  }

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      name: name ?? '',
      amount: amount ?? 0.0,
      date: date ?? DateTime.now(),
    );
  }
}
