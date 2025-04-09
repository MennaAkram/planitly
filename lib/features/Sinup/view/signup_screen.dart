import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Login/view/login_screen.dart';
import 'package:planitly/shared/assests.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:planitly/shared/widgets/text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

TextEditingController UsernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {
    return 
         Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: Theme.of(context).appColors.gradientTB,
        ),
        child: SingleChildScrollView(child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: SvgPicture.asset(Assests.logo),
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
              padding: const EdgeInsets.all(10),child: 
            Form(
                key: stateform,
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: "Username",
                      controller: UsernameController,
                    ),
                    CustomTextField(
                      labelText: "Email",
                      controller: emailController,
                    
                    ),
                    CustomTextField(
                      labelText: "Password",
                      controller: passwordController,
                      isPassword: true,
                    ),
                  ],
                )),
           
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: Builder(builder: (context) {
                return CustomButton(
                    text: "SingUp",
                    onPressed: () {
                      if(stateform.currentState!.validate()){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Email is not valid",
                              style: Theme.of(context)
                                  .appTexts
                                  .bodySmall
                                  .copyWith(
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
                      }
                    },
                    outlined: false);
              }),
            ),
            Container(
                alignment: Alignment.center,
                child:
                    TextButton(
                        onPressed: () {
                            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Loginscreen()),
  );
                        },
                        child: Wrap(children: [Text(
                        "already have an account? ",
                        style: Theme.of(context).appTexts.labelSmall.copyWith(
                            color: Theme.of(context).appColors.white87),
                      ),
                        Text(
                          ' Login',
                          style: Theme.of(context).appTexts.labelSmall.copyWith(
                                color: Theme.of(context).appColors.primary,
                              ),
                        )],)
                      )
                  
                ),
          ],
        ),)
      ),
    );
  }
}
