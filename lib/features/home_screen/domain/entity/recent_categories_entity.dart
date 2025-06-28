class RecentCategoriesEntity {
  final String id;
  final String name;
  final int subjectsCount;
  final DateTime createdAt;

  RecentCategoriesEntity({
    required this.id,
    required this.name,
    required this.subjectsCount,
    required this.createdAt,
  });
}