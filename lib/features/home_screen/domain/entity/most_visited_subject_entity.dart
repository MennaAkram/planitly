class MostVisitedSubjectEntity {
  final String id;
  final String name;
  final String category;
  final String template;
  final int timesVisited;
  final DateTime lastVisited;

  MostVisitedSubjectEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.template,
    required this.timesVisited,
    required this.lastVisited,
  });
}