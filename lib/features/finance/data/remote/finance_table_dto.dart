import 'package:planitly/features/finance/data/remote/finance_record_dto.dart';
import 'package:planitly/features/finance/domain/entity/finance_table_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class FinanceTableDto extends BaseMapper<FinanceTableDto> {
  String? id;
  List<FinanceRecordDto>? records;

  FinanceTableDto({
    this.id,
    this.records,
  });

  @override
  Map<String, dynamic> toJson(FinanceTableDto object) {
    return {
      'id': object.id,
      'items': object.records?.map((record) => record.toJson(record)).toList(),
    };
  }

  @override
  FinanceTableDto fromJson(Map<String, dynamic> json) {
    return FinanceTableDto(
      id: json['id'] as String?,
      records: (json['data']['items'] as List)
          .map((record) => FinanceRecordDto().fromJson(record))
          .toList(),
    );
  }

  FinanceTableEntity toEntity() {
    return FinanceTableEntity(
      id: id ?? '',
      records: FinanceRecordDto().toEntityList(records ?? []),
    );
  }
}