import 'package:flutter/material.dart';


class NavigatorHelper {
  static GlobalKey<NavigatorState> get navigatorKey => NavigationService().navigatorKey;

  static BuildContext get context => navigatorKey.currentState!.context;

  static Future<dynamic> push(Widget page) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );

  static Future<dynamic> pushNamedAndRemoveUntil(String page) =>
      Navigator.pushNamedAndRemoveUntil(
          NavigatorHelper.context, page, (route) => false);

  static Future<dynamic> pushReplacement(Widget page) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => page),
            (Route<dynamic> route) => false,
      );

  static void pop() => Navigator.pop(context);

  static Future<dynamic> restart() =>
      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
}

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory NavigationService() {
    return _instance;
  }

  NavigationService._internal();
}