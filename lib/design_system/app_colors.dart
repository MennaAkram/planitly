import 'package:flutter/material.dart';

class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  final Color primary;
  final Color secondary;
  final Color background;
  final LinearGradient gradientLR;
  final LinearGradient gradientTB;
  final Color black16;
  final Color black37;
  final Color black60;
  final Color black87;
  final Color white100;
  final Color white87;
  final Color white60;
  final Color white37;
  final Color white16;
  final Color red;
  final Color green;
  final Color blue;
  final Color purple;

  const AppColorsTheme._internal({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.gradientLR,
    required this.gradientTB,
    required this.black16,
    required this.black37,
    required this.black60,
    required this.black87,
    required this.white100,
    required this.white87,
    required this.white60,
    required this.white37,
    required this.white16,
    required this.red,
    required this.green,
    required this.blue,
    required this.purple,
  });

  factory AppColorsTheme.light() {
    return const AppColorsTheme._internal(
      primary: Color(0xFFFC5D00),
      secondary: Color(0xFFFFEEE3),
      background: Color(0xFFFFFFFF),
      gradientLR: LinearGradient(colors: [
        Color(0xFF002FFF),
        Color(0xFFFC5D00),
      ]),
      gradientTB: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF002FFF),
            Color(0xFFFC5D00),
          ]),
      black16: Color(0x29121212),
      black37: Color(0x5E121212),
      black60: Color(0x99121212),
      black87: Color(0xde121212),
      white100: Color(0xFFFFFFFF),
      white87: Color(0xDDFFFFFF),
      white60: Color(0x99FFFFFF),
      white37: Color(0x5EFFFFFF),
      white16: Color(0x29FFFFFF),
      red: Color(0xFFEB1418),
      green: Color(0xFF079500),
      blue: Color(0xFF8F9CE8),
      purple: Color(0xFFBB98E7),
    );
  }

  @override
  ThemeExtension<AppColorsTheme> copyWith() {
    return AppColorsTheme.light();
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
          covariant ThemeExtension<AppColorsTheme>? other, double t) =>
      this;
}
