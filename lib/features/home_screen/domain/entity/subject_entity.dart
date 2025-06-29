class SubjectEntity {
  final String id;
  final String? name;
  final String template;
  final String category;
  final List<String> components;
  final List<String> widgets;
  final bool isDeletable;
  final String owner;
  final DateTime createdAt;
  final int timesVisited;
  final DateTime lastVisited;

  SubjectEntity({
    required this.id,
    this.name,
    required this.template,
    required this.category,
    required this.components,
    required this.widgets,
    required this.isDeletable,
    required this.owner,
    required this.createdAt,
    required this.timesVisited,
    required this.lastVisited,
  });
}