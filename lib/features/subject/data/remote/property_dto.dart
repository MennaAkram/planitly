import 'package:planitly/features/subject/domain/entity/property_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class PropertyDto extends BaseMapper<PropertyDto> {
  String? id;
  String? name;
  PropertyType? type;
  dynamic value;

  PropertyDto({
    this.id,
    this.name,
    this.type,
    this.value,
  });

  @override
  PropertyDto fromJson(Map<String, dynamic> json) {
    PropertyType type = PropertyType.string;

    switch (json['comp_type'] as String) {
      case 'int' || 'double':
        type = PropertyType.number;
        break;
      case 'date':
        type = PropertyType.date;
        break;
      case 'phone':
        type = PropertyType.phone;
        break;
      case 'Array_generic':
        type = PropertyType.list;
        break;
      case 'Array_type':
        type = PropertyType.intList;
        break;
    }

    return PropertyDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: type,
      value: type == PropertyType.list || type == PropertyType.intList
          ? json['data']['items']
          : json['data']['item'],
    );
  }

  @override
  Map<String, dynamic> toJson(PropertyDto object) {
    return {
      'id': object.id,
      'name': object.name,
      'type': object.type?.name,
      'data': object.value,
    };
  }

  PropertyEntity toEntity() {
    return PropertyEntity(
      id: id ?? '',
      name: name ?? '',
      type: type ?? PropertyType.string,
      value: value,
    );
  }
}
