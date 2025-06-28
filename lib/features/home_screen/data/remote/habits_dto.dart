import 'package:planitly/features/home_screen/domain/entity/habits_entity.dart';

import '../../../../shared/bases/base_mapper.dart';
import 'habit_dto.dart';

class HabitsDto extends BaseMapper<HabitsDto> {
  int? totalHabits;
  int? doneToday;
  int? notDoneToday;
  double? completionRate;
  List<HabitDto>? doneHabits;
  List<HabitDto>? notDoneHabits;
  List<HabitDto>? detailedProgress;

  HabitsDto({
     this.totalHabits,
     this.doneToday,
     this.notDoneToday,
     this.completionRate,
     this.doneHabits,
     this.notDoneHabits,
     this.detailedProgress,
  });

  @override
  Map<String, dynamic> toJson(HabitsDto object) {
    return {
      'total_habits': object.totalHabits,
      'done_today': object.doneToday,
      'not_done_today': object.notDoneToday,
      'completion_rate': object.completionRate,
      'done_habits': object.doneHabits,
      'not_done_habits': object.notDoneHabits,
      'detailed_progress': object.detailedProgress,
    };
  }

  @override
  HabitsDto fromJson(Map<String, dynamic> json) {
    return HabitsDto(
      totalHabits: json['total_habits'],
      doneToday: json['done_today'],
      notDoneToday: json['not_done_today'],
      completionRate: json['completion_rate'],
      doneHabits: (json['done_habits'] as List).map((item) => HabitDto().fromJson(item)).toList(),
      notDoneHabits: (json['not_done_habits'] as List).map((item) => HabitDto().fromJson(item)).toList(),
      detailedProgress: (json['detailed_progress'] as List).map((item) => HabitDto().fromJson(item)).toList(),
    );
  }

  HabitsEntity toEntity() {
    return HabitsEntity(
      totalHabits: totalHabits ?? 0,
      doneToday: doneToday ?? 0,
      notDoneToday: notDoneToday ?? 0,
      completionRate: completionRate ?? 0.0,
      doneHabits: doneHabits?.map((e) => e.toEntity()).toList() ?? [],
      notDoneHabits: notDoneHabits?.map((e) => e.toEntity()).toList() ?? [],
      detailedProgress: detailedProgress?.map((e) => e.toEntity()).toList() ?? [],
    );
  }

}