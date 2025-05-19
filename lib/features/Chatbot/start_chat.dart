// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/assests.dart';

class StartChat extends StatefulWidget {
  const StartChat({super.key});

  @override
  State<StartChat> createState() => _StartChatState();
}

class _StartChatState extends State<StartChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Wrap(children: [
            Container(
              height: 24,
              width: 24,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(Assests.chatbot))),
            ),
            Text(
              "ChatBot",
              style: Theme.of(context).appTexts.bodyLarge,
            ),
          ]),
        ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Theme.of(context).appColors.white100,
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: SvgPicture.asset(Assests.background)),
            ),
            Container(
                height: double.maxFinite,
                width: double.maxFinite,
                alignment: Alignment.center,
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    SvgPicture.asset(Assests.chatmassage),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      margin: EdgeInsets.symmetric(horizontal: 48),
                      child: CustomButton(
                        text: "     start chat              ",
                        onPressed: () {},
                        outlined: false,
                        addIcon: true,
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
