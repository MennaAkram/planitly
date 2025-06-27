import 'package:planitly/features/subject/data/remote/data_dto.dart';
import 'package:planitly/features/subject/domain/entity/string_data_entity.dart';

class StringDataDto extends DataDto {
  String? value;

  StringDataDto({this.value});

  @override
  StringDataDto fromJson(Map<String, dynamic> json) {
    return StringDataDto(
      value: json['item'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson(DataDto object) {
    return {
      'item': (object as StringDataDto).value ?? '',
    };
  }

  @override
  StringDataEntity toEntity() {
    return StringDataEntity(value: value ?? '');
  }
}
