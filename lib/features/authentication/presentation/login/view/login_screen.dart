import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/authentication/presentation/register/presentation/view/signup_screen.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:planitly/shared/widgets/text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController UsernameController1 = TextEditingController();
TextEditingController passwordController1 = TextEditingController();
GlobalKey<FormState> stateform = GlobalKey();

class _LoginScreenState extends State<LoginScreen> {
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
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: SvgPicture.asset(Assets.logo),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text("Login",
                      style: Theme.of(context).appTexts.titleMedium.copyWith(
                            color: Theme.of(context).appColors.white87,
                          )),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CustomTextField(
                        labelText: "Username or Email",
                        controller: UsernameController1,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        labelText: "Password",
                        controller: passwordController1,
                        isPassword: true,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forget your password? ",
                            style: Theme.of(context)
                                .appTexts
                                .bodySmall
                                .copyWith(
                                    color: Theme.of(context).appColors.white37),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(24),
                  child: Builder(builder: (context) {
                    return CustomButton(
                        text: "login",
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Email or username doesn’t exist",
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
                              margin: const EdgeInsets.all(24),
                            ),
                          );
                        },
                        outlined: false);
                  }),
                ),
                Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
                  Text(
                    "don’t have an account?",
                    style: Theme.of(context)
                        .appTexts
                        .labelSmall
                        .copyWith(color: Theme.of(context).appColors.white87),
                  ),
                  TextButton(
                      onPressed: () {
                        NavigatorHelper.push(SignUpScreen());
                      },
                      child: Text(
                        'SignUp',
                        style: Theme.of(context).appTexts.labelSmall.copyWith(
                            color: Theme.of(context).appColors.primary),
                      ))
                ]),
              ],
            ),
          )),
    );
  }
}
