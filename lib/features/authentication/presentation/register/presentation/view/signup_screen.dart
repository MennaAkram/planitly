import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:planitly/app/di.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/authentication/presentation/register/presentation/cubit/register_cubit.dart';
import 'package:planitly/features/authentication/presentation/register/presentation/widgets/date_text_field.dart';
import 'package:planitly/features/authentication/presentation/register/presentation/widgets/phone_text_field.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/navigator_helper.dart';
import 'package:planitly/shared/validators.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:planitly/shared/widgets/text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../login/presentation/view/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _stateform = GlobalKey<FormState>();
  final RegisterCubit _cubit = getIt.get<RegisterCubit>();
  String _countryCode = '+20';
  bool _submitting = false;
  int _currentStep = 0;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    birthdateController.dispose();
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
            NavigatorHelper.pushReplacement(LoginScreen(
              isVerified: true,
            ));
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
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => setState(() {
                        _currentStep = 0;
                        _submitting = false;
                      }),
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 35,
                          height: 35,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Theme.of(context).appColors.primary,
                              width: 2,
                            ),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).appColors.primary,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: _currentStep == 1
                                    ? SvgPicture.asset(
                                        Assets.check,
                                      )
                                    : null,
                              ))),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).appColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 35,
                      height: 35,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Theme.of(context).appColors.primary,
                          width: 2,
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _currentStep == 1
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).appColors.primary,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _stateform,
                  autovalidateMode: _submitting
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: const Offset(0.4, 0.0),
                        end: Offset.zero,
                      ).animate(animation);
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      key: ValueKey<int>(_currentStep),
                      children: [
                        if (_currentStep == 0) ...[
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  labelText: "First Name",
                                  controller: firstNameController,
                                  keyboardType: TextInputType.name,
                                  validator: Validators.nameValidator,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: CustomTextField(
                                  labelText: "Last Name",
                                  controller: lastNameController,
                                  keyboardType: TextInputType.name,
                                  validator: Validators.nameValidator,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          PhoneNumberTextField(
                            labelText: "Phone Number",
                            controller: phoneController,
                            validator: Validators.phoneNumberValidator,
                            onChanged: (countryCode, number) {
                              setState(() {
                                _countryCode = countryCode;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          DateTextField(
                            labelText: "Birthdate Date",
                            controller: birthdateController,
                            validator: Validators.cantBeEmpty,
                          )
                        ] else ...[
                          CustomTextField(
                            labelText: "Username",
                            controller: usernameController,
                            keyboardType: TextInputType.name,
                            validator: Validators.usernameValidator,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            labelText: "Email",
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.emailValidator,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            labelText: "Password",
                            controller: passwordController,
                            isPassword: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: Validators.passwordValidator,
                          ),
                        ]
                      ],
                    ),
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
                        text: _currentStep == 0 ? "Continue" : "Sign Up",
                        onPressed: () {
                          if (_stateform.currentState!.validate()) {
                            if (_currentStep == 0) {
                              setState(() {
                                _currentStep = 1;
                                _submitting = false;
                              });
                            } else {
                              _cubit.register(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                phoneNumber:
                                    '$_countryCode${phoneController.text}',
                                birthdayDate: (DateFormat("MMM dd, yyyy")
                                        .parse(birthdateController.text))
                                    .toIso8601String(),
                                username: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          } else {
                            if (!_submitting) {
                              setState(() {
                                _submitting = true;
                              });
                            }
                          }
                        },
                        outlined: false,
                      );
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
                        NavigatorHelper.pushReplacement(LoginScreen());
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
