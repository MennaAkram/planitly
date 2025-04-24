import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitly/app/di.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/authentication/presentation/login/presentation/cubit/login_cubit.dart';
import 'package:planitly/features/authentication/presentation/register/presentation/view/signup_screen.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'package:planitly/features/bottomNavBar.dart';
import 'package:planitly/shared/validators.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:planitly/shared/widgets/text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  final bool isVerified;

  const LoginScreen({super.key, this.isVerified = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameOrEmailConteoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _stateform = GlobalKey();
  final LoginCubit _cubit = getIt.get<LoginCubit>();
  bool _submitting = false;

  @override
  void initState() {
    if (widget.isVerified) {
      showSnackBar();
    }
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
    usernameOrEmailConteoller.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, BaseState>(
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
                    child: Form(
                      key: _stateform,
                      autovalidateMode: _submitting
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          CustomTextField(
                            labelText: "Username or Email",
                            controller: usernameOrEmailConteoller,
                            validator: Validators.cantBeEmpty,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            labelText: "Password",
                            controller: passwordController,
                            isPassword: true,
                            validator: Validators.passwordValidator,
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
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(24),
                    child: BlocBuilder<LoginCubit, BaseState>(
                        bloc: _cubit,
                        builder: (context, state) {
                          if (state is LoadingState) {
                            return const CircularProgressIndicator();
                          } else {
                            return CustomButton(
                                text: "login",
                                onPressed: () {
                                  if (_stateform.currentState!.validate()) {
                                    _cubit.login(
                                      usernameOremail:
                                          usernameOrEmailConteoller.text,
                                      password: passwordController.text,
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
                        }),
                  ),
                  Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "don’t have an account?",
                          style: Theme.of(context).appTexts.labelSmall.copyWith(
                              color: Theme.of(context).appColors.white87),
                        ),
                        TextButton(
                            onPressed: () {
                              NavigatorHelper.push(SignUpScreen());
                            },
                            child: Text(
                              'SignUp',
                              style: Theme.of(context)
                                  .appTexts
                                  .labelSmall
                                  .copyWith(
                                      color:
                                          Theme.of(context).appColors.primary),
                            ))
                      ]),
                ],
              ),
            )),
      ),
    );
  }
}
