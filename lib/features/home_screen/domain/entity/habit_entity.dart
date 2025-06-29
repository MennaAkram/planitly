class HabitEntity {
  final String id;
  final String name;
  final String category;
  final bool isDone;
  final double completionPercentage;
  final bool manuallyMarked;
  final bool hasTodos;
  final int todosCount;
  final int completedTodosCount;
  final DateTime createdAt;

  HabitEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.isDone,
    required this.completionPercentage,
    required this.manuallyMarked,
    required this.hasTodos,
    required this.todosCount,
    required this.completedTodosCount,
    required this.createdAt,
});
}