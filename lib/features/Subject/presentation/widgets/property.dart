class Property {
  final String name;
  dynamic value;
  final PropertyType type;

  Property({required this.name, required this.value, required this.type});

  @override
  String toString() {
    return 'Property{name: $name, value: $value, type: $type}';
  }

  Property copyWith({String? name, dynamic? value, PropertyType? type}) {
    return Property(
      name: name ?? this.name,
      value: value ?? this.value,
      type: type ?? this.type,
    );
  }
}

class WidgetDefinition {
  final String name;
  final List<Type> requiredTypes;

  WidgetDefinition({required this.name, required this.requiredTypes});
}
enum WidgetType { pieChart, donutChart, todoList, table, picture, textField, checkBox, numberLink, toContacts, calender }
enum PropertyType { string, number, boolean, list, intList, map }

extension WidgetsName on WidgetType {
  String get name {
    switch (this) {
      case WidgetType.pieChart : return 'Pie Chart';
      case WidgetType.donutChart : return 'Donut Chart';
      case WidgetType.todoList : return 'TodoList';
      case WidgetType.table : return 'Table';
      case WidgetType.picture : return 'Picture';
      case WidgetType.textField : return 'TextField';
      case WidgetType.checkBox : return 'CheckBox';
      case WidgetType.numberLink : return 'Number Link';
      case WidgetType.toContacts : return 'To contacts';
      case WidgetType.calender : return 'Calender';
    }
  }
}

extension PropertiesName on PropertyType {
  String get name {
    switch (this) {
      case PropertyType.string : return 'Text';
      case PropertyType.number : return 'Number';
      case PropertyType.boolean : return 'Condition';
      case PropertyType.list : return 'List';
      case PropertyType.intList : return 'Charts Data';
      case PropertyType.map : return 'Map';
    }
  }
}