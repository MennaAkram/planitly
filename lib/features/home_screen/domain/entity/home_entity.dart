import 'package:planitly/features/home_screen/domain/entity/recent_categories_entity.dart';
import 'package:planitly/features/home_screen/domain/entity/templates_entity.dart';
import 'connections_entity.dart';
import 'habits_entity.dart';
import 'most_visited_subject_entity.dart';
import 'user_stats_entity.dart';

class HomeEntity {
  final DateTime date;
  final UserStatsEntity userState;
  final HabitsEntity habits;
  final ConnectionsEntity connections;
  final List<MostVisitedSubjectEntity> mostVisitedSubjects;
  final List<RecentCategoriesEntity> recentCategories;
  final TemplatesEntity templates;

  HomeEntity({
    required this.date,
    required this.userState,
    required this.habits,
    required this.connections,
    required this.mostVisitedSubjects,
    required this.recentCategories,
    required this.templates,
  });
}