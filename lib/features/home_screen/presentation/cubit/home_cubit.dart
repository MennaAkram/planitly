import 'package:planitly/features/home_screen/domain/entity/custom_template_entity.dart';
import 'package:planitly/features/home_screen/domain/entity/template_entity.dart';
import 'package:planitly/features/home_screen/domain/repositories/home_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';
import '../../domain/entity/connections_entity.dart';
import '../../domain/entity/habits_entity.dart';
import '../../domain/entity/most_visited_subject_entity.dart';
import '../../domain/entity/recent_categories_entity.dart';
import '../../domain/entity/user_stats_entity.dart';

class HomeCubit extends BaseCubit {
  final HomeRepository _homeRepo;

  HomeCubit(this._homeRepo) : super(const InitState());

  DateTime date = DateTime.now();
  UserStatsEntity userState = UserStatsEntity(
    totalSubjects: 0,
    totalCategories: 0,
    totalConnections: 0,
  );
  HabitsEntity habits = HabitsEntity(
    totalHabits: 0,
    doneToday: 0,
    notDoneToday: 0,
    completionRate: 0.0,
    doneHabits: [],
    notDoneHabits: [],
    detailedProgress: [],
  );
  ConnectionsEntity connections = ConnectionsEntity(
    totalToday: 0,
    connections: [],
  );
  List<MostVisitedSubjectEntity> mostVisitedSubjects = [];
  List<RecentCategoriesEntity> recentCategories = [];
  List<TemplateEntity> predefinedTemplate = [];
  List<CustomTemplateEntity> customTemplate = [];

  allTemplates() {
    return [...predefinedTemplate, ...customTemplate];
  }

  getData() async {
    emit(const LoadingState());

    final result = await _homeRepo.getHomeData();

    return result.fold(
      (exception) {
        handleException(exception);
      },
      (data) {
        date = data.date;
        userState = data.userState;
        habits = data.habits;
        connections = data.connections;
        mostVisitedSubjects = data.mostVisitedSubjects;
        recentCategories = data.recentCategories;
        predefinedTemplate = data.templates.predefined;
        customTemplate = data.templates.custom;

        emit(DoneState());
      },
    );
  }

  void addPage(
      {required String name,
      required String id,
      required String category,
      required String template,
      required int timesVisited,
      required DateTime lastVisited}) {
    final newPage = MostVisitedSubjectEntity(
        id: id,
        name: name,
        category: category,
        template: template,
        timesVisited: timesVisited,
        lastVisited: lastVisited); // Replace with your actual entity
    mostVisitedSubjects.add(newPage);
    emit(DoneState()); // Re-emit to rebuild UI
  }
}
