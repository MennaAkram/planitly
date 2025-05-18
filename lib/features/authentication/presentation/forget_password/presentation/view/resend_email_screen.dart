import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/authentication/presentation/forget_password/presentation/view/forget_password_screen.dart';
import 'package:planitly/features/authentication/presentation/login/presentation/view/login_screen.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'package:planitly/shared/widgets/button.dart';

class ResendEmailScreen extends StatelessWidget {
  final String email;

  const ResendEmailScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).appColors.background,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.resendEmailPlaceholder,
              ),
              const SizedBox(
                height: 32,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    email,
                    style: Theme.of(context).appTexts.bodyMedium.copyWith(
                          color: Theme.of(context).appColors.black60,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Reset Password Email Sent',
                    style: Theme.of(context).appTexts.titleSmall.copyWith(
                          color: Theme.of(context).appColors.black60,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Your account security is our priority! We’ve sent you a secure link to safely change your password and keep your Account protected.',
                    style: Theme.of(context).appTexts.bodySmall.copyWith(
                          color: Theme.of(context).appColors.black60,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                    text: "Done",
                    onPressed: () =>
                        NavigatorHelper.pushReplacement(LoginScreen()),
                    outlined: false,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextButton(
                              onPressed: () {
                                NavigatorHelper.push(ForgetPasswordScreen());
                              },
                              child: Text(
                                "Resend Email",
                                style: Theme.of(context)
                                    .appTexts
                                    .labelSmall
                                    .copyWith(
                                        color: Theme.of(context)
                                            .appColors
                                            .black60),
                              ),
                            ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
