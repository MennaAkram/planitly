// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/assests.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planitly/shared/widgets/button.dart';

void showlogoutPopup(BuildContext context, VoidCallback onUpdate) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text("Logout",
                    style: Theme.of(context)
                        .appTexts
                        .titleSmall
                        .copyWith(color: Theme.of(context).appColors.black87))
              ],
            ),
            SizedBox(height: 25),
            SvgPicture.asset(Assests.Logout),
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  text: 'Cancel',
                  onPressed: () {
                    onUpdate();
                    Navigator.pop(context);
                  },
                  outlined: false,
                )),
                SizedBox(width: 10),
                Expanded(
                    child: CustomButton(
                  text: 'Logout',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  outlined: true,
                )),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
