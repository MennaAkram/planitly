import 'package:uuid/uuid.dart';

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
  contact,
  calender
}

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
      case WidgetType.contact:
        return 'Contact';
      case WidgetType.calender:
        return 'Calendar';
    }
  }
}