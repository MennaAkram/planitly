import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/chatbotscreen/chatbot.dart';
import 'package:planitly/features/loginscreen.dart';
import 'package:planitly/features/signupscreen.dart';
import 'package:planitly/shared/assests.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:planitly/shared/widgets/text_field.dart';
import 'design_system/app_colors.dart';
import 'design_system/app_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColorsTheme.light().primary,
              secondary: AppColorsTheme.light().secondary,
              surface: AppColorsTheme.light().background,
              error: AppColorsTheme.light().red,
            ),
        extensions: [
          AppColorsTheme.light(),
          AppTextsTheme.main(),
        ],
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home: Scaffold(
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
    ));
}
}