import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/authentication/presentation/reset_password/presentation/view/reset_password_screen.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'package:planitly/shared/validators.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:planitly/shared/widgets/text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailConteoller = TextEditingController();
  final GlobalKey<FormState> _stateform = GlobalKey();
  bool _submitting = false;

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
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text("Verfiy Your Email",
                    style: Theme.of(context).appTexts.titleMedium.copyWith(
                          color: Theme.of(context).appColors.white87,
                        )),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _stateform,
                    autovalidateMode: _submitting
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    child: Column(children: [
                      CustomTextField(
                        labelText: "Email",
                        controller: emailConteoller,
                        validator: Validators.emailValidator,
                      ),
                    ])),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(24),
                child: CustomButton(
                    text: "Verify",
                    onPressed: () {
                      if (_stateform.currentState!.validate()) {
                        NavigatorHelper.pushReplacement(ResetPasswordScreen());
                      } else {
                        if (!_submitting) {
                          setState(() {
                            _submitting = true;
                          });
                        }
                      }
                    },
                    outlined: false),
              ),
            ]),
          )),
    );
  }
}
