import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Chatbot/presentation/widgets/appbar.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartChat extends StatelessWidget {
  final VoidCallback onStartChat;

  const StartChat({super.key, required this.onStartChat});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Appbar(),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Theme.of(context).appColors.white100,
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: SvgPicture.asset(Assets.background)),
            ),
            Container(
                height: double.maxFinite,
                width: double.maxFinite,
                alignment: Alignment.center,
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    SvgPicture.asset(Assets.chatMassage),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      margin: EdgeInsets.symmetric(horizontal: 48),
                      child: CustomButton(
                        text: "Start Chat",
                        onPressed: onStartChat,
                        outlined: false,
                        
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
