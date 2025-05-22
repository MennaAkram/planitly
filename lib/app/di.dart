import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:planitly/features/authentication/data/repositories/authentication_repo_impl.dart';
import 'package:planitly/features/authentication/domain/repositories/authentication_repo.dart';
import 'package:planitly/features/authentication/presentation/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:planitly/features/authentication/presentation/login/presentation/cubit/login_cubit.dart';
import 'package:planitly/features/authentication/presentation/register/presentation/cubit/register_cubit.dart';
import 'package:planitly/features/finance/data/repositories/finance_repo_impl.dart';
import 'package:planitly/features/finance/domain/repositories/finance_repo.dart';
import 'package:planitly/features/finance/presentation/cubit/finance_cubit.dart';
import 'package:planitly/features/my_pages/data/repositories/pages_repo_impl.dart';
import 'package:planitly/features/my_pages/domain/repositories/pages_repo.dart';
import 'package:planitly/features/my_pages/presentation/cubit/pages_cubit.dart';
import 'package:planitly/features/notifications/data/repositories/notifications_repo_impl.dart';
import 'package:planitly/features/notifications/domain/repositories/notifications_repo.dart';
import 'package:planitly/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:planitly/shared/local_storage_manager.dart';
import 'package:planitly/shared/networking/app_dio.dart';
import 'package:planitly/shared/networking/app_interceptor.dart';

import '../shared/navigator_helper.dart';
import '../shared/notification_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  const String planitlyService = 'planitlyService';

  // LOCAL
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerSingleton<LocalStorageManager>(LocalStorageManager(getIt()));
 // getIt.registerSingleton<NotificationService>(NotificationService());
 // getIt.registerSingleton<FirebaseMessaging>(FirebaseMessaging.instance);

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
}
