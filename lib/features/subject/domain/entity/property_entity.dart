import 'package:planitly/features/subject/domain/entity/data_entity.dart';

class PropertyEntity {
  final String id;
  final String name;
  final PropertyType type;
  final DataEntity data;

  PropertyEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.data,
  });
}

enum PropertyType { string, number, boolean, list, intList, map, phone, date }

extension PropertiesName on PropertyType {
  String get name {
    switch (this) {
      case PropertyType.string:
        return 'Text';
      case PropertyType.number:
        return 'Number';
      case PropertyType.boolean:
        return 'Condition';
      case PropertyType.list:
        return 'List';
      case PropertyType.intList:
        return 'Charts Data';
      case PropertyType.map:
        return 'Map';
      case PropertyType.phone:
        return 'Phone';
      case PropertyType.date:
        return 'Date';
    }
  }
}
