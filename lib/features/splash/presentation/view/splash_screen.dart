import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/authentication/presentation/login/presentation/view/login_screen.dart';
import 'package:planitly/features/bottomNavBar.dart';
import 'package:planitly/shared/navigator_helper.dart';

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;
  const SplashScreen({super.key, required this.isLoggedIn});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserAndNavigate();
  }

  Future<void> _checkUserAndNavigate() async {
    
    await Future.delayed(const Duration(seconds: 2));
    if (widget.isLoggedIn) {
      NavigatorHelper.pushReplacement(Bottomnavbar());
    } else {
      NavigatorHelper.pushReplacement(LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.background,
      body: Center(
        child: Lottie.asset(
          'assets/animations/logo.json',
          width: 140,
          height: 140,
          fit: BoxFit.contain,
          repeat: false,
        ),
      ),
    );
  }
}