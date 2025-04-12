import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/bottomNavBar.dart';
import 'package:planitly/shared/navigator_helper.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      NavigatorHelper.pushReplacement(Bottomnavbar());
    });
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