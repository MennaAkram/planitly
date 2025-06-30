import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:planitly/features/Chatbot/domain/repositories/chatbot_repo.dart';
import 'package:planitly/features/authentication/data/repositories/authentication_repo_impl.dart';
import 'package:planitly/features/authentication/domain/repositories/authentication_repo.dart';
import 'package:planitly/features/authentication/presentation/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:planitly/features/authentication/presentation/login/presentation/cubit/login_cubit.dart';
import 'package:planitly/features/authentication/presentation/register/presentation/cubit/register_cubit.dart';
import 'package:planitly/features/emails/data/repositories/emails_repo_impl.dart';
import 'package:planitly/features/emails/domain/repositories/emails_repo.dart';
import 'package:planitly/features/categories/data/repositories/categories_repo_impl.dart';
import 'package:planitly/features/categories/domain/repositories/categories_repo.dart';
import 'package:planitly/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:planitly/features/category/data/repository/category_repo_impl.dart';
import 'package:planitly/features/category/domain/repository/category_repo.dart';
import 'package:planitly/features/category/presentation/cubit/category_cubit.dart';
import 'package:planitly/features/finance/data/repositories/finance_repo_impl.dart';
import 'package:planitly/features/finance/domain/repositories/finance_repo.dart';
import 'package:planitly/features/finance/presentation/cubit/finance_cubit.dart';
import 'package:planitly/features/home_screen/domain/repositories/home_repo.dart';
import 'package:planitly/features/home_screen/presentation/cubit/home_cubit.dart';
import 'package:planitly/features/my_pages/data/repositories/pages_repo_impl.dart';
import 'package:planitly/features/my_pages/domain/repositories/pages_repo.dart';
import 'package:planitly/features/my_pages/presentation/cubit/pages_cubit.dart';
import 'package:planitly/features/notifications/data/repositories/notifications_repo_impl.dart';
import 'package:planitly/features/notifications/domain/repositories/notifications_repo.dart';
import 'package:planitly/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:planitly/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:planitly/features/profile/domain/repositories/profile_repo.dart';
import 'package:planitly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:planitly/features/subject/data/repository/subject_repo_impl.dart';
import 'package:planitly/features/subject/domain/repository/subject_repo.dart';
import 'package:planitly/features/subject/presentation/cubit/subject_cubit.dart';
import 'package:planitly/shared/emails_service.dart';
import 'package:planitly/shared/local_storage_manager.dart';
import 'package:planitly/shared/networking/app_dio.dart';
import 'package:planitly/shared/networking/app_interceptor.dart';
import '../features/emails/presentation/cubit/emails_cubit.dart';
import '../features/Chatbot/data/repositories/chatbot_repo_impl.dart';
import '../features/Chatbot/presentation/cubit/chatbot_cubit.dart';
import '../features/home_screen/data/repositories/home_repo_impl.dart';
import '../shared/navigator_helper.dart';
import '../shared/notification_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  const String planitlyService = 'planitlyService';

  // LOCAL
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerSingleton<LocalStorageManager>(LocalStorageManager(getIt()));
  getIt.registerSingleton<NotificationService>(NotificationService());
  getIt.registerSingleton<FirebaseMessaging>(FirebaseMessaging.instance);
  getIt.registerSingleton<EmailsService>(EmailsService());

  // NETWORK INTERCEPTOR
  getIt.registerSingleton<AppInterceptor>(
      AppInterceptor(getIt<LocalStorageManager>()));

  // NETWORK
  getIt.registerSingleton<Dio>(
    appDio(getIt<AppInterceptor>()),
    instanceName: planitlyService,
  );

  // REPOSITORIES
  getIt.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(
      getIt<Dio>(instanceName: planitlyService),
      getIt<LocalStorageManager>(),
    ),
  );

  getIt.registerSingleton<NotificationsRepository>(
    NotificationsRepositoryImpl(
      getIt<Dio>(instanceName: planitlyService),
      getIt<LocalStorageManager>(),
    ),
  );

  getIt.registerSingleton<FinanceRepository>(
    FinanceRepositoryImpl(
      getIt<Dio>(instanceName: planitlyService),
      getIt<LocalStorageManager>(),
    ),
  );

  getIt.registerSingleton<PagesRepository>(
    PagesRepositoryImpl(
      getIt<Dio>(instanceName: planitlyService),
    ),
  );

  getIt.registerSingleton<ProfileRepository>(
    ProfileRepositoryImpl(
      getIt<Dio>(instanceName: planitlyService),
    ),
  );

  getIt.registerSingleton<EmailsRepository>(
    EmailsRepositoryImpl(
      getIt<Dio>(instanceName: planitlyService),
      getIt<EmailsService>(),
    ),
  );

  getIt.registerSingleton<CategoriesRepository>(
    CategoriesRepositoryImpl(
      getIt<Dio>(instanceName: planitlyService),
    ),
  );

  getIt.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl(
      getIt<Dio>(instanceName: planitlyService),
    ),
  );

  getIt.registerSingleton<ChatbotRepository>(
    ChatbotRepositoryImpl(
      getIt<Dio>(instanceName: planitlyService),
    ),
  );

  getIt.registerSingleton<SubjectRepository>(
    SubjectRepositoryImpl(
      getIt<Dio>(instanceName: planitlyService),
    ),
  );

  getIt.registerSingleton<HomeRepository>(
    HomeRepositoryImpl(
      getIt<Dio>(instanceName: planitlyService),
    ),
  );

  // CUBITS
  getIt.registerFactory<LoginCubit>(() => LoginCubit(
        getIt<AuthenticationRepository>(),
      ));

  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(
        getIt<AuthenticationRepository>(),
      ));

  getIt.registerFactory<ForgetPasswordCubit>(() => ForgetPasswordCubit(
        getIt<AuthenticationRepository>(),
      ));

  getIt.registerFactory<NotificationsCubit>(() => NotificationsCubit(
        getIt<NotificationsRepository>(),
      ));

  getIt.registerFactory<FinanceCubit>(() => FinanceCubit(
        getIt<FinanceRepository>(),
      ));

  getIt.registerFactory<PagesCubit>(() => PagesCubit(
        getIt<PagesRepository>(),
      ));

  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(
        getIt<ProfileRepository>(),
      ));

  getIt.registerFactory<EmailsCubit>(() => EmailsCubit(
        getIt<EmailsRepository>(),
      ));

  getIt.registerFactory<CategoriesCubit>(() => CategoriesCubit(
        getIt<CategoriesRepository>(),
      ));

  getIt.registerFactory<CategoryCubit>(() => CategoryCubit(
        getIt<CategoryRepository>(),
      ));

  getIt.registerFactory<ChatbotCubit>(() => ChatbotCubit(
        getIt<ChatbotRepository>(),
      ));

  getIt.registerFactory<SubjectCubit>(() => SubjectCubit(
        getIt<SubjectRepository>(),
      ));

  getIt.registerFactory<HomeCubit>(() => HomeCubit(
        getIt<HomeRepository>(),
        getIt<PagesRepository>(),
        getIt<CategoriesRepository>(),
      ));

}
