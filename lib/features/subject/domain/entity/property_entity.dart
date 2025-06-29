import 'package:uuid/uuid.dart';

class PropertyEntity {
  final String id;
  final String name;
  final PropertyType type;
  final dynamic value;

  PropertyEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.value,
  });

  PropertyEntity.withoutId(
      {required this.name, required this.value, required this.type})
      : id = const Uuid().v4();

  PropertyEntity copyWith({String? name, dynamic value, PropertyType? type}) {
    return PropertyEntity(
      name: name ?? this.name,
      value: value ?? this.value,
      type: type ?? this.type,
      id: id,
    );
  }
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
