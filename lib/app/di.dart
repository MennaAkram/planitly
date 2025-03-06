import 'package:get_it/get_it.dart';

import '../shared/navigator_helper.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  const String planitlyService = 'planitlyService';

  getIt.registerSingleton<NavigationService>(NavigationService());
  }