import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import '../../../../shared/assets.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {

  const Appbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24), // to respect iOS status bar
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.white100,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 32,
              width: 32,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(Assets.chatbot), // use your chatbot asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "ChatBot",
              style: Theme.of(context).appTexts.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
