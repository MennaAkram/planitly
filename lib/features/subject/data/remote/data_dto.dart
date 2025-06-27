import 'package:planitly/features/subject/data/remote/string_data_dto.dart';
import 'package:planitly/features/subject/domain/entity/data_entity.dart';
import 'package:planitly/features/subject/domain/entity/property_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

abstract class DataDto extends BaseMapper<DataDto> {
  DataDto();

  factory DataDto.fromJson(Map<String, dynamic> json, PropertyType type) {
    switch (type) {
      case PropertyType.string:
        return StringDataDto().fromJson(json['data']);
      default:
        throw Exception('Unknown data type');
    }
  }

  DataEntity toEntity();
}
