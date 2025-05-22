import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/profile/presentation/widget/textfield.dart';
import 'package:planitly/shared/widgets/button.dart';

void showEditPopup(
    BuildContext context,
    VoidCallback onUpdate,
    TextEditingController fristnameController,
    TextEditingController lastnameController,
    TextEditingController phoneController,
    TextEditingController birthdayController) {
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
                Text("Edit Info",
                    style: Theme.of(context)
                        .appTexts
                        .titleSmall
                        .copyWith(color: Theme.of(context).appColors.black87))
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: text_field(
                        controller: fristnameController, title: 'fristname')),
                SizedBox(width: 10),
                Expanded(
                    child: text_field(
                        controller: lastnameController, title: 'lastname')),
              ],
            ),
            SizedBox(height: 20),
            text_field(controller: phoneController, title: 'phone'),
            SizedBox(height: 20),
            text_field(controller: birthdayController, title: 'birthday'),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  text: 'Update',
                  onPressed: () {
                    onUpdate();
                    Navigator.pop(context);
                  },
                  outlined: false,
                )),
                SizedBox(width: 10),
                Expanded(
                    child: CustomButton(
                  text: 'Cancel',
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
