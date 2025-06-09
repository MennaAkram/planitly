import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/authentication/presentation/register/presentation/widgets/date_text_field.dart';
import 'package:planitly/features/authentication/presentation/register/presentation/widgets/phone_text_field.dart';
import 'package:planitly/features/profile/presentation/widget/change_pop_screen.dart';
import 'package:planitly/features/profile/presentation/widget/contact_item.dart';
import 'package:planitly/features/profile/presentation/widget/logout_pop_screen.dart';
import 'package:planitly/features/profile/presentation/widget/profile_button.dart';
import 'package:planitly/generated/l10n.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/validators.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:planitly/shared/widgets/extensions.dart';
import 'package:planitly/shared/widgets/text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController fristNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController birthdayDateController = TextEditingController();
  final TextEditingController oldpassController = TextEditingController();
  final TextEditingController newpassController = TextEditingController();
  final TextEditingController cnewpassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String fristname = 'Menna';
  String lastname = 'Akram';
  String BirthdayDate = '1/1/1976';
  String phonenumber = '01244539870';

  @override
  void dispose() {
    fristNameController.dispose();
    lastNameController.dispose();
    birthdayDateController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.background,
      appBar: CustomAppBar(
        title: AppLocalizations.current.profile,
        postfixIcon: Assets.edit,
        onPostfixIconPressed: _openEditDialog,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(Assets.profile))),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 1),
            height: 20,
            child: Text(
              "$fristname $lastname",
              style: Theme.of(context)
                  .appTexts
                  .titleSmall
                  .copyWith(color: Theme.of(context).appColors.black87),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 1),
            height: 15,
            child: Text(
              "mennaakram12",
              style: Theme.of(context)
                  .appTexts
                  .bodySmall
                  .copyWith(color: Theme.of(context).appColors.black60),
            ),
          ),
          SizedBox(
            height: 9,
          ),
          SvgPicture.asset(Assets.line1),
          SizedBox(
            height: 29,
          ),
          ContactItem(
            iconPath: Assets.phone,
            title: 'Phone Number',
            value: phonenumber,
          ),
          SizedBox(height: 20),
          ContactItem(
            iconPath: Assets.email,
            title: 'Email',
            value: 'menna@gmail.com',
          ),
          SizedBox(height: 20),
          ContactItem(
            iconPath: Assets.birthday,
            title: 'Birthday',
            value: BirthdayDate,
          ),
          SizedBox(height: 30),
          SvgPicture.asset(Assets.line2),
          SizedBox(height: 20),
          Button(
            text: "My Pages",
            onTap: () {},
          ),
          Button(
            text: "Change Password",
            onTap: () => showchangePopup(context, () {}, oldpassController,
                newpassController, cnewpassController),
          ),
          Button(
            text: "Settings",
            onTap: () {},
          ),
          Button(
            text: "Logout",
            textColor: Theme.of(context).appColors.red,
            onTap: () => showlogoutPopup(context, () {}),
          ),
        ],
      ),
    );
  }

  void _openEditDialog() {
    fristNameController.text = fristname;
    lastNameController.text = lastname;
    phoneNumberController.text = phonenumber;
    birthdayDateController.text = BirthdayDate;

    context.alertDialog(
      AppLocalizations.current.editInfo,
      AppLocalizations.current.update,
      AppLocalizations.current.cancel,
      () {
        if (_formKey.currentState?.validate() ?? false) {
          Navigator.of(context).pop();
        }
      },
      () => Navigator.of(context).pop(),
      Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    labelText: AppLocalizations.current.firstName,
                    controller: fristNameController,
                    keyboardType: TextInputType.name,
                    validator: Validators.nameValidator,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomTextField(
                    labelText: AppLocalizations.current.lastName,
                    controller: lastNameController,
                    keyboardType: TextInputType.name,
                    validator: Validators.nameValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            PhoneNumberTextField(
              labelText: AppLocalizations.current.phoneNumber,
              controller: phoneNumberController,
              validator: Validators.phoneNumberValidator,
            ),
            const SizedBox(height: 16),
            DateTextField(
              labelText: AppLocalizations.current.birthdayDate,
              controller: birthdayDateController,
              validator: Validators.cantBeEmpty,
            ),
          ],
        ),
      ),
    );
  }
}
