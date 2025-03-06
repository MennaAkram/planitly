import 'package:flutter/material.dart';
import 'package:planitly/features/bottomNavBar.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'app/di.dart';
import 'design_system/app_colors.dart';
import 'design_system/app_text.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: getIt<NavigationService>().navigatorKey,
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColorsTheme.light().primary,
              secondary: AppColorsTheme.light().secondary,
              surface: AppColorsTheme.light().background,
              error: AppColorsTheme.light().red,
            ),
        extensions: [
          AppColorsTheme.light(),
          AppTextsTheme.main(),
        ],
      ),
      home: const Bottomnavbar(),
    );
  }
}