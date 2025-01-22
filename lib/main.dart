import 'package:flutter/material.dart';
import 'design_system/app_colors.dart';
import 'design_system/app_text.dart';
import 'package:planitly/features/Calendar/presentation/view/calendar_screen.dart';
import 'package:planitly/features/Graph_View/presentation/view/graph_view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      initialRoute: '/calendar',
      routes: {
        '/calendar': (context) => const CalendarScreen(),
        '/graph_view': (context) => const GraphViewScreen(),
      },
    );
  }
}
