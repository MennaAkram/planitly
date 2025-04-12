import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitly/app/di.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/authentication/presentation/register/presentation/cubit/register_cubit.dart';
import 'package:planitly/features/bottomNavBar.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'package:planitly/shared/validators.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:planitly/shared/widgets/text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../login/view/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _stateform = GlobalKey<FormState>();
  final RegisterCubit _cubit = getIt.get<RegisterCubit>();
  bool _submitting = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterCubit, BaseState>(
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
                margin: const EdgeInsets.all(20),
              ),
            );
          } else if (state is DoneState) {
            NavigatorHelper.pushReplacement(Bottomnavbar());
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
                padding: const EdgeInsets.all(5),
                child: Text("SignUp",
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
                        labelText: "Username",
                        controller: usernameController,
                        validator: Validators.usernameValidator,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        labelText: "Email",
                        controller: emailController,
                        validator: Validators.emailValidator,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        labelText: "Password",
                        controller: passwordController,
                        isPassword: true,
                        validator: Validators.passwordValidator,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: BlocBuilder<RegisterCubit, BaseState>(
                  bloc: _cubit,
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const CircularProgressIndicator();
                    } else {
                      return CustomButton(
                          text: "SingUp",
                          onPressed: () {
                            if (_stateform.currentState!.validate()) {
                              _cubit.register(
                                usernameController.text,
                                emailController.text,
                                passwordController.text,
                              );
                            } else {
                              if (!_submitting) {
                                setState(() {
                                  _submitting = true;
                                });
                              }
                            }
                          },
                          outlined: false);
                    }
                  },
                ),
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
      ),
    );
  }
}
