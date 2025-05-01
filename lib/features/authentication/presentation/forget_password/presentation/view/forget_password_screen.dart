import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/app/di.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/authentication/presentation/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:planitly/features/authentication/presentation/forget_password/presentation/view/resend_email_screen.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/bases/base_state.dart';
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
  final ForgetPasswordCubit _cubit = getIt.get<ForgetPasswordCubit>();
  final GlobalKey<FormState> _stateform = GlobalKey();
  bool _submitting = false;

  @override
  void dispose() {
    emailConteoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ForgetPasswordCubit, BaseState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg!,
                    style: Theme.of(context).appTexts.bodySmall.copyWith(
                          color: Theme.of(context).appColors.red,
                        )),
                backgroundColor: Theme.of(context).appColors.white100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(24),
              ),
            );
          } else if (state is DoneState) {
            NavigatorHelper.pushReplacement(ResendEmailScreen(email: emailConteoller.text,));
          }
        },
        child: Container(
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
                  child: BlocBuilder<ForgetPasswordCubit, BaseState>(
                    bloc: _cubit,
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return const CircularProgressIndicator();
                      }
                      return CustomButton(
                          text: "Verify",
                          onPressed: () {
                            if (_stateform.currentState!.validate()) {
                              _cubit.verifyEmail(email: emailConteoller.text);
                            } else {
                              if (!_submitting) {
                                setState(() {
                                  _submitting = true;
                                });
                              }
                            }
                          },
                          outlined: false);
                    },
                  ),
                ),
              ]),
            )),
      ),
    );
  }
}
