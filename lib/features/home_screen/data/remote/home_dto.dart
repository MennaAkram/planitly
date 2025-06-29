import 'package:planitly/features/home_screen/data/remote/recent_categories_dto.dart';
import 'package:planitly/features/home_screen/data/remote/templates_dto.dart';
import 'package:planitly/features/home_screen/data/remote/user_stats_dto.dart';
import 'package:planitly/features/home_screen/domain/entity/home_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';
import 'connections_dto.dart';
import 'finance_dto.dart';
import 'habits_dto.dart';
import 'most_visited_subject_dto.dart';

class HomeDto extends BaseMapper<HomeDto> {
  DateTime? date;
  UserStatsDto? userState;
  HabitsDto? habits;
  ConnectionsDto? connections;
  List<MostVisitedSubjectDto>? mostVisitedSubjects;
  List<RecentCategoriesDto>? recentCategories;
  TemplatesDto? templates;
  FinanceDto? financeTracker;

  HomeDto({
    this.date,
    this.userState,
    this.habits,
    this.connections,
    this.mostVisitedSubjects,
    this.recentCategories,
    this.templates,
    this.financeTracker,
  });

  @override
  HomeDto fromJson(Map<String, dynamic> json) {
    return HomeDto(
      date: DateTime.tryParse(json['date'] ?? ''),
      userState: json['user_stats'] != null
          ? UserStatsDto().fromJson(json['user_stats'] as Map<String, dynamic>)
          : null,
      habits: json['habits'] != null
          ? HabitsDto().fromJson(json['habits'] as Map<String, dynamic>)
          : null,
      connections: json['connections'] != null
          ? ConnectionsDto().fromJson(json['connections'] as Map<String, dynamic>)
          : null,
      mostVisitedSubjects: (json['most_visited_subjects'] as List<dynamic>?)
          ?.map((e) => MostVisitedSubjectDto().fromJson(e as Map<String, dynamic>))
          .toList(),
      recentCategories: (json['recent_categories'] as List<dynamic>?)
          ?.map((e) => RecentCategoriesDto().fromJson(e as Map<String, dynamic>))
          .toList(),
      templates: json['templates'] != null
          ? TemplatesDto().fromJson(json['templates'] as Map<String, dynamic>)
          : null,
      financeTracker: json['finance_tracker'] != null
          ? FinanceDto().fromJson(json['finance_tracker'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson(HomeDto object) {
    return {
      'date': object.date?.toIso8601String(),
      'userState': object.userState?.toJson(object.userState!),
      'habits': object.habits?.toJson(object.habits!),
      'connections': object.connections?.toJson(object.connections!),
      'mostVisitedSubjects': object.mostVisitedSubjects?.map((e) => e.toJson(
        object.mostVisitedSubjects!.firstWhere((subject) => subject.id == e.id, orElse: () => e),
      )).toList(),
      'recentCategories': object.recentCategories?.map((e) => e.toJson(
        object.recentCategories!.firstWhere((category) => category.id == e.id, orElse: () => e),
      )).toList(),
      'templates': object.templates?.toJson(object.templates!),
      'finance_tracker': object.financeTracker?.toJson(object.financeTracker!),
    };
  }


  HomeEntity toEntity() {
    return HomeEntity(
      date: date ?? DateTime.now(),
      userState: userState?.toEntity() ?? UserStatsDto().toEntity(),
      habits: habits?.toEntity() ?? HabitsDto().toEntity(),
      connections: connections?.toEntity() ?? ConnectionsDto().toEntity(),
      mostVisitedSubjects: mostVisitedSubjects?.map((e) => e.toEntity()).toList() ?? [],
      recentCategories: recentCategories?.map((e) => e.toEntity()).toList() ?? [],
      templates: templates?.toEntity() ?? TemplatesDto().toEntity(),
      finance: financeTracker?.toEntity() ?? FinanceDto().toEntity(),
    );
  }
}