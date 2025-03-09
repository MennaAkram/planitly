// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/assests.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:planitly/shared/widgets/text_field.dart';

import 'package:flutter_svg/flutter_svg.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _MyHomePageState();
}

TextEditingController UsernameController1 = TextEditingController();
TextEditingController passwordController1 = TextEditingController();
GlobalKey<FormState> stateform = GlobalKey();

class _MyHomePageState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: Theme.of(context).appColors.gradientTB,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: SvgPicture.asset(Assests.logo),
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
                  padding: const EdgeInsets.all(10),
                  child: Form(
                      key: stateform,
                      child: Column(
                        children: [
                          CustomTextField(
                            labelText: "Username or Email",
                            controller: UsernameController1,
                          ),
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
                                        color: Theme.of(context)
                                            .appColors
                                            .white37),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
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
                              backgroundColor: Theme.of(context).appColors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(20),
                            ),
                          );
                        },
                        outlined: false);
                  }),
                ),
                Container(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {},
                        child: Wrap(
                          children: [
                            Text(
                              "don’t have an account?",
                              style: Theme.of(context)
                                  .appTexts
                                  .labelSmall
                                  .copyWith(
                                      color:
                                          Theme.of(context).appColors.white87),
                            ),
                            Text(
                              ' Signup',
                              style: Theme.of(context)
                                  .appTexts
                                  .labelSmall
                                  .copyWith(
                                    color: Theme.of(context).appColors.primary,
                                  ),
                            )
                          ],
                        ))),
              ],
            ),
          )),
    ));
  }
}
