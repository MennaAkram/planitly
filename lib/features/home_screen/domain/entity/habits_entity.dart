import 'habit_entity.dart';

class HabitsEntity {
  final int totalHabits;
  final int doneToday;
  final int notDoneToday;
  final double completionRate;
  final List<HabitEntity> doneHabits;
  final List<HabitEntity> notDoneHabits;
  final List<HabitEntity> detailedProgress;

  HabitsEntity({
    required this.totalHabits,
    required this.doneToday,
    required this.notDoneToday,
    required this.completionRate,
    required this.doneHabits,
    required this.notDoneHabits,
    required this.detailedProgress,
  });
}