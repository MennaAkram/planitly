import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:planitly/features/authentication/data/repositories/authentication_repo_impl.dart';
import 'package:planitly/features/authentication/domain/repositories/authentication_repo.dart';

import 'package:planitly/features/authentication/presentation/register/presentation/cubit/register_cubit.dart';
import 'package:planitly/shared/local_storage_manager.dart';
import 'package:planitly/shared/networking/app_dio.dart';
import 'package:planitly/shared/networking/app_interceptor.dart';

import '../shared/navigator_helper.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  const String planitlyService = 'planitlyService';

  // LOCAL
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerSingleton<LocalStorageManager>(LocalStorageManager(getIt()));

  // NETWORK INTERCEPTOR
  getIt.registerSingleton<AppInterceptor>(AppInterceptor(getIt<LocalStorageManager>()));

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

  // CUBITS
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(
        getIt<AuthenticationRepository>(),
      ));
}
