import 'package:planitly/features/finance/domain/entity/finance_record_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class FinanceRecordDto extends BaseMapper<FinanceRecordDto> {
  String? name;
  double? amount;
  DateTime? date;
  DateTime? createdAt;

  FinanceRecordDto({
    this.name,
    this.amount,
    this.date,
    this.createdAt,
  });

  @override
  Map<String, dynamic> toJson(FinanceRecordDto object) {
    return {
      'name': object.name,
      'amount': object.amount,
      'date': object.date?.toIso8601String(),
      'created_at': object.createdAt?.toIso8601String(),
    };
  }

  @override
  FinanceRecordDto fromJson(Map<String, dynamic> json) {
    final raw = (json['value']['value'] as String? ?? '')
        .split(';')
        .map((s) => s.trim())
        .toList();

    final amt = raw.isNotEmpty ? double.tryParse(raw[0]) : 0.0;
    final dt = raw.length > 1
        ? DateTime.parse(raw[1]) // <— real DateTime
        : DateTime.now();

    return FinanceRecordDto(
      name: json['value']['key'] as String?,
      amount: amt,
      date: dt,
      createdAt: DateTime.parse(json['created_at']) as DateTime?,
    );
  }

  List<FinanceRecordEntity> toEntityList(List<FinanceRecordDto> data) {
    return data.map((e) => e.toEntity()).toList();
  }

  FinanceRecordEntity toEntity() {
    return FinanceRecordEntity(
      name: name ?? '',
      amount: amount ?? 0.0,
      date: date ?? DateTime.now(),
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}
