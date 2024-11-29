import 'package:uuid/uuid.dart';

class Property {
  final String id;
  final String name;
  dynamic value;
  final PropertyType type;

  Property(
      {required this.name,
      required this.value,
      required this.type,
      required this.id});

  Property.withoutId(
      {required this.name, required this.value, required this.type})
      : id = const Uuid().v4();

  @override
  String toString() {
    return 'Property{id: $id, name: $name, value: $value, type: $type}';
  }

  Property copyWith({String? name, dynamic value, PropertyType? type}) {
    return Property(
      name: name ?? this.name,
      value: value ?? this.value,
      type: type ?? this.type,
      id: id,
    );
  }
}

class WidgetDefinition {
  String id;
  final String name;
  final List<Type> requiredTypes;

  WidgetDefinition({required this.name, required this.requiredTypes})
      : id = const Uuid().v4();

  @override
  String toString() {
    return 'WidgetDefinition{id: $id, name: $name, requiredTypes: $requiredTypes}';
  }

  WidgetDefinition copyWith({String? name, List<Type>? requiredTypes}) {
    return WidgetDefinition(
      name: name ?? this.name,
      requiredTypes: requiredTypes ?? this.requiredTypes,
    )..id = id;
  }
}

enum WidgetType {
  pieChart,
  donutChart,
  todoList,
  table,
  picture,
  textField,
  checkBox,
  toContacts,
  calender
}

enum PropertyType { string, number, boolean, list, intList, map, phone }

extension WidgetsName on WidgetType {
  String get name {
    switch (this) {
      case WidgetType.pieChart:
        return 'Pie Chart';
      case WidgetType.donutChart:
        return 'Donut Chart';
      case WidgetType.todoList:
        return 'To-Do List';
      case WidgetType.table:
        return 'Table';
      case WidgetType.picture:
        return 'Picture';
      case WidgetType.textField:
        return 'Text Field';
      case WidgetType.checkBox:
        return 'Check Box';
      case WidgetType.toContacts:
        return 'To Contacts';
      case WidgetType.calender:
        return 'Calendar';
    }
  }
}

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
    }
  }
}
