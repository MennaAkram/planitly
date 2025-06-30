import 'package:dartz/dartz.dart';
import 'package:planitly/features/categories/domain/repositories/categories_repo.dart';
import 'package:planitly/features/home_screen/domain/entity/custom_template_entity.dart';
import 'package:planitly/features/home_screen/domain/entity/finance_entity.dart';
import 'package:planitly/features/home_screen/domain/entity/subject_entity.dart';
import 'package:planitly/features/home_screen/domain/entity/template_entity.dart';
import 'package:planitly/features/home_screen/domain/repositories/home_repo.dart';
import 'package:planitly/features/my_pages/domain/repositories/pages_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';
import '../../../../shared/networking/failures.dart';
import '../../../categories/domain/entity/category_entity.dart';
import '../../../my_pages/domain/entity/page_entity.dart';
import '../../domain/entity/connections_entity.dart';
import '../../domain/entity/habits_entity.dart';
import '../../domain/entity/most_visited_subject_entity.dart';
import '../../domain/entity/recent_categories_entity.dart';
import '../../domain/entity/user_stats_entity.dart';

class HomeCubit extends BaseCubit {
  final HomeRepository _homeRepo;
  final PagesRepository _pagesRepo;
  final CategoriesRepository _categoriesRepo;

  HomeCubit(this._homeRepo, this._pagesRepo, this._categoriesRepo) : super(const InitState());

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
  FinanceEntity financeTracker = FinanceEntity(
    subject: SubjectEntity(
        id: '',
        template: '', category: '', components: [], widgets: [],
        isDeletable: false, owner: '', createdAt: DateTime.now(),
        timesVisited: 0, lastVisited: DateTime.now(), name: ''),
    components: [],
    widgets: [],
  );

  List<PageEntity> pages = [];
  List<PageEntity> selectedPages = [];
  List<CategoryEntity> categories = [];
  bool isAdding = false;

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
        financeTracker = data.finance;

        emit(DoneState());
      },
    );
  }

  Future<void> addPage({required String name}) async {
    if (isAdding) return;
    isAdding = true;
    emit(LoadingState());

    Either<NetworkException, PageEntity> result =
    await _pagesRepo.addPage(name: name);

    result.fold(
          (NetworkException exception) {
        handleException(exception);
      },
          (PageEntity newPage) {
        pages.insert(0, newPage);
        mostVisitedSubjects.insert(0, MostVisitedSubjectEntity(
          id: newPage.id,
          name: newPage.name,
          category: '',
          template: '',
          lastVisited: DateTime.now(),
          timesVisited: 0
        ));
        emit(DoneState());
      },
    );

    isAdding = false;
  }

  Future<void> addCategory({required String name}) async {
    if (isAdding) return;
    emit(const LoadingState());

    isAdding = true;

    final result = await _categoriesRepo.addCategory(name: name, pageIds: [for (var page in selectedPages) page.id]);

    result.fold(
          (NetworkException exception) {
        handleException(exception);
      },
          (category) {
        categories.insert(0, category);
        emit(const DoneState());
      },
    );

    isAdding = false;
  }

  void addTemplate({
    required String name
  }) {
    final newTemplate = TemplateEntity(
      type: 'custom',
      name: name,
      category: '',
      description: ''
    );
    predefinedTemplate.add(newTemplate);
    emit(DoneState());
  }
}
