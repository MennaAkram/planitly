class ComponentsEntity {
  final String name;
  final String id;
  final Map<String, dynamic> data;
  final String compType;
  final String hostSubject;
  final String owner;
  final bool isDeletable;
  final List<String> referencedByWidgets;
  final String allowedWidgetType;

  ComponentsEntity({
    required this.name,
    required this.id,
    required this.data,
    required this.compType,
    required this.hostSubject,
    required this.owner,
    required this.isDeletable,
    required this.referencedByWidgets,
    required this.allowedWidgetType,
  });
}
