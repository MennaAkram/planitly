import 'package:flutter/material.dart';
import 'package:planitly/features/splash/presentation/view/splash_screen.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'app/di.dart';
import 'design_system/app_colors.dart';
import 'design_system/app_text.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
      home: const SplashScreen(),
    );
  }
}