import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:planitly/shared/widgets/text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../login/view/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

TextEditingController UsernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Theme.of(context).appColors.white60,
            gradient: Theme.of(context).appColors.gradientTB,
          ),
          child: SingleChildScrollView(
              child: Column(children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: SvgPicture.asset(Assets.logo),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: Text("SignUp",
                  style: Theme.of(context).appTexts.titleMedium.copyWith(
                        color: Theme.of(context).appColors.white87,
                      )),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomTextField(
                    labelText: "Username",
                    controller: UsernameController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    labelText: "Email",
                    controller: emailController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    labelText: "Password",
                    controller: passwordController,
                    isPassword: true,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: Builder(builder: (context) {
                return CustomButton(
                    text: "SingUp",
                    onPressed: () {
                      if (stateform.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Email is not valid",
                                style: Theme.of(context)
                                    .appTexts
                                    .bodySmall
                                    .copyWith(
                                      color: Theme.of(context).appColors.red,
                                    )),
                            backgroundColor:
                                Theme.of(context).appColors.white100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(20),
                          ),
                        );
                      }
                    },
                    outlined: false);
              }),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "already have an account?",
                  style: Theme.of(context)
                      .appTexts
                      .labelSmall
                      .copyWith(color: Theme.of(context).appColors.white87),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      'Login',
                      style: Theme.of(context).appTexts.labelSmall.copyWith(
                            color: Theme.of(context).appColors.primary,
                          ),
                    )),
              ],
            ),
          ]))),
    );
  }
}
