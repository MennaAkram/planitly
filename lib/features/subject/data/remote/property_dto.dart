import 'package:planitly/features/subject/data/remote/data_dto.dart';
import 'package:planitly/features/subject/domain/entity/property_entity.dart';
import 'package:planitly/features/subject/domain/entity/string_data_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class PropertyDto extends BaseMapper<PropertyDto> {
  String? id;
  String? name;
  PropertyType? type;
  DataDto? data;

  PropertyDto({
    this.id,
    this.name,
    this.type,
    this.data,
  });

  @override
  PropertyDto fromJson(Map<String, dynamic> json) {
    PropertyType type = PropertyType.string;

    switch (json['comp_type'] as String) {
      case 'str':
        type = PropertyType.string;
        break;
      default:
        type = PropertyType.string;
    }

    return PropertyDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: type,
      data: DataDto.fromJson(json['data'] as Map<String, dynamic>, type),
    );
  }

  @override
  Map<String, dynamic> toJson(PropertyDto object) {
    return {
      'id': object.id,
      'name': object.name,
      'type': object.type?.name,
      'data': object.data?.toJson(object.data!),
    };
  }

  PropertyEntity toEntity() {
    return PropertyEntity(
      id: id ?? '',
      name: name ?? '',
      type: type ?? PropertyType.string,
      data: data?.toEntity() ?? const StringDataEntity(value: ''),
    );
  }
}
