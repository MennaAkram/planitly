import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController _fristNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthdayDateController = TextEditingController();
  final TextEditingController _oldpassController = TextEditingController();
  final TextEditingController _newpassController = TextEditingController();
  final TextEditingController _cnewpassController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;
  String fristname = 'Menna';
  String lastname = 'Akram';
  String username = "mennaakram12";
  String BirthdayDate = '1/1/1976';
  String phonenumber = '01244539870';

  @override
  void dispose() {
    _fristNameController.dispose();
    _lastNameController.dispose();
    _birthdayDateController.dispose();
    _phoneNumberController.dispose();
    _oldpassController.dispose();
    _newpassController.dispose();
    _cnewpassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.background,
      appBar: _buildProfileAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(
              height: 10,
            ),
            _line(70),
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
            _line(140),
            SizedBox(height: 20),
            Button(
              text: "My Pages",
              onTap: () {},
            ),
            Button(
              text: "Change Password",
              onTap: () => showchangePopup(context, () {}, _oldpassController,
                  _newpassController, _cnewpassController),
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
      ),
    );
  }

  Divider _line(double indent) {
    return Divider(
      height: 0.5,
      color: Theme.of(context).appColors.black16,
      indent: indent,
      endIndent: indent,
    );
  }

  CustomAppBar _buildProfileAppBar() {
    return CustomAppBar(
      title: AppLocalizations.current.profile,
      postfixIcon: Assets.edit,
      onPostfixIconPressed: _openEditDialog,
    );
  }

  Column _buildProfileHeader() {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(60),
          onTap: _pickImage,
          child: Container(
            height: 80,
            width: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: _profileImage != null
                        ? FileImage(_profileImage!) as ImageProvider
                        : AssetImage(Assets.profile))),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "$fristname $lastname",
          style: Theme.of(context)
              .appTexts
              .titleSmall
              .copyWith(color: Theme.of(context).appColors.black87),
        ),
        Text(
          username,
          style: Theme.of(context)
              .appTexts
              .bodySmall
              .copyWith(color: Theme.of(context).appColors.black60),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final toolbarColor = Theme.of(context).appColors.primary;
    final toolbarWidgetColor = Theme.of(context).appColors.white100;
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: toolbarColor,
            toolbarWidgetColor: toolbarWidgetColor,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _profileImage = File(croppedFile.path);
        });
      }
    }
  }

  void _openEditDialog() {
    _fristNameController.text = fristname;
    _lastNameController.text = lastname;
    _phoneNumberController.text = phonenumber;
    _birthdayDateController.text = BirthdayDate;

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
                    controller: _fristNameController,
                    keyboardType: TextInputType.name,
                    validator: Validators.nameValidator,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomTextField(
                    labelText: AppLocalizations.current.lastName,
                    controller: _lastNameController,
                    keyboardType: TextInputType.name,
                    validator: Validators.nameValidator,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            PhoneNumberTextField(
              labelText: AppLocalizations.current.phoneNumber,
              controller: _phoneNumberController,
              validator: Validators.phoneNumberValidator,
            ),
            const SizedBox(height: 16),
            DateTextField(
              labelText: AppLocalizations.current.birthdayDate,
              controller: _birthdayDateController,
              validator: Validators.cantBeEmpty,
            ),
          ],
        ),
      ),
    );
  }
}
