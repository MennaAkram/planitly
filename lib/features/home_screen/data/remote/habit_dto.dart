import 'package:planitly/shared/bases/base_mapper.dart';

import '../../domain/entity/habit_entity.dart';

class HabitDto extends BaseMapper<HabitDto> {
  String? id;
  String? name;
  String? category;
  bool? isDone;
  double? completionPercentage;
  bool? manuallyMarked;
  bool? hasTodos;
  int? todosCount;
  int? completedTodosCount;
  DateTime? createdAt;

  HabitDto({
    this.id,
    this.name,
    this.category,
    this.isDone,
    this.completionPercentage,
    this.manuallyMarked,
    this.hasTodos,
    this.todosCount,
    this.completedTodosCount,
    this.createdAt,
});

  @override
  HabitDto fromJson(Map<String, dynamic> json) {
    return HabitDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      isDone: json['is_done'] as bool?,
      completionPercentage: (json['completion_percentage'] as num?)?.toDouble(),
      manuallyMarked: json['manually_marked'] as bool?,
      hasTodos: json['has_todos'] as bool?,
      todosCount: json['todos_count'] as int?,
      completedTodosCount: json['completed_todos_count'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson(HabitDto object) {
    return {
      'id': object.id,
      'name': object.name,
      'category': object.category,
      'is_done': object.isDone,
      'completion_percentage': object.completionPercentage,
      'manually_marked': object.manuallyMarked,
      'has_todos': object.hasTodos,
      'todos_count': object.todosCount,
      'completed_todos_count': object.completedTodosCount,
      'created_at': object.createdAt?.toIso8601String(),
    };
  }

  HabitEntity toEntity() {
    return HabitEntity(
      id: id ?? '',
      name: name ?? '',
      category: category ?? '',
      isDone: isDone ?? false,
      completionPercentage: completionPercentage ?? 0.0,
      manuallyMarked: manuallyMarked ?? false,
      hasTodos: hasTodos ?? false,
      todosCount: todosCount ?? 0,
      completedTodosCount: completedTodosCount ?? 0,
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}