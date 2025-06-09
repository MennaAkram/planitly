import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/profile/presentation/widget/phonenumper.dart';
import 'package:planitly/features/profile/presentation/widget/textfield.dart';
import 'package:planitly/shared/widgets/button.dart';

import '../../../../shared/validators.dart';
import '../../../authentication/presentation/register/presentation/widgets/date_text_field.dart';

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
      backgroundColor: Theme.of(context).appColors.background,
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
            Phonenumper(phoneController: phoneController),
            SizedBox(height: 20),
            const SizedBox(height: 16),
            DateTextField(
              labelText: "Birthday Date",
              controller: birthdayController,
              validator: Validators.cantBeEmpty,
            ),
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
