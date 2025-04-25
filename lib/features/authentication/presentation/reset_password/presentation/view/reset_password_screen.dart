import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/authentication/presentation/login/presentation/view/login_screen.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'package:planitly/shared/validators.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:planitly/shared/widgets/text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController newPasswordConteoller = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  final GlobalKey<FormState> _stateform = GlobalKey();
  bool _submitting = false;

  @override
  void initState() {
    showSnackBar();
    super.initState();
  }

  void showSnackBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Registered Successfully, Please Verify your email.",
            style: Theme.of(context).appTexts.bodySmall.copyWith(
                  color: Theme.of(context).appColors.green,
                )),
        backgroundColor: Theme.of(context).appColors.white100,
        duration: const Duration(seconds: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(24),
      ));
    });
  }

  @override
  void dispose() {
    newPasswordConteoller.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

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
                  child: Text("Reset new password",
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
                    child: Column(
                      children: [
                        CustomTextField(
                          labelText: "New Password",
                          controller: newPasswordConteoller,
                          isPassword: true,
                          validator: Validators.passwordValidator,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          labelText: "Confirm New Password",
                          controller: confirmNewPasswordController,
                          isPassword: true,
                          validator: (value) =>
                              Validators.confirmPasswordValidator(
                                  value, newPasswordConteoller.text),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(24),
                  child: CustomButton(
                      text: "Reset",
                      onPressed: () {
                        if (_stateform.currentState!.validate()) {
                          NavigatorHelper.pushReplacement(LoginScreen());
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
              ],
            ),
          )),
    );
  }
}
