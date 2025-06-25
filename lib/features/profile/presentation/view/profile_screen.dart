import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:planitly/app/di.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/authentication/presentation/login/presentation/view/login_screen.dart';
import 'package:planitly/features/authentication/presentation/register/presentation/widgets/date_text_field.dart';
import 'package:planitly/features/authentication/presentation/register/presentation/widgets/phone_text_field.dart';
import 'package:planitly/features/my_pages/presentation/view/my_pages_screen.dart';
import 'package:planitly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:planitly/features/profile/presentation/widget/contact_item.dart';
import 'package:planitly/features/profile/presentation/widget/profile_button.dart';
import 'package:planitly/generated/l10n.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/bases/base_state.dart';
import 'package:planitly/shared/navigator_helper.dart';
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
  final ProfileCubit _cubit = getIt.get<ProfileCubit>();
  final TextEditingController _fristNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthdayDateController = TextEditingController();
  final TextEditingController _oldpassController = TextEditingController();
  final TextEditingController _newpassController = TextEditingController();
  final TextEditingController _cnewpassController = TextEditingController();
  final GlobalKey<FormState> _editDataFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _changePasswordFormKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _cubit.getProfileData();
  }

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
      body: BlocListener<ProfileCubit, BaseState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is ErrorState && state.msg != "Token has expired") {
            context.showCustomSnackBar(state.msg!);
          } else if (state is DoneState) {
            if (_cubit.isLoggingOut) {
              NavigatorHelper.pushReplacement(LoginScreen());
            } else if (_cubit.isPasswordChanged) {
              context.showCustomSnackBar(
                  AppLocalizations.current.passwordChangedSuccessfully);
              _cubit.isPasswordChanged = false;
            }
          }
        },
        child: BlocBuilder<ProfileCubit, BaseState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state is LoadingState &&
                !_cubit.isImageUploading &&
                !_cubit.iseditingProfile) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileHeader(),
                  const SizedBox(
                    height: 10,
                  ),
                  _line(70),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildContactInfo(),
                  const SizedBox(height: 20),
                  _line(140),
                  SizedBox(height: 16),
                  _buildActionButtons(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _line(double indent) {
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

  Widget _buildProfileHeader() {
    return Column(
      children: [
        BlocBuilder<ProfileCubit, BaseState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state is LoadingState && _cubit.isImageUploading) {
              return Center(
                  child: Container(
                margin: const EdgeInsets.all(22),
                child: const CircularProgressIndicator(),
              ));
            }
            return _buildProfileImage();
          },
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '${_cubit.profileDataEntity.firstName} ${_cubit.profileDataEntity.lastName}',
          style: Theme.of(context)
              .appTexts
              .titleSmall
              .copyWith(color: Theme.of(context).appColors.black87),
        ),
        Text(
          _cubit.profileDataEntity.username,
          style: Theme.of(context)
              .appTexts
              .bodySmall
              .copyWith(color: Theme.of(context).appColors.black60),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return InkWell(
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
                image: _cubit.profileDataEntity.profileImage != ''
                    ? NetworkImage(
                        _cubit.profileDataEntity.profileImage,
                      )
                    : _cubit.profileImage != null
                        ? FileImage(_cubit.profileImage!) as ImageProvider
                        : AssetImage(Assets.profile))),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: BlocBuilder<ProfileCubit, BaseState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is LoadingState && _cubit.iseditingProfile) {
            return Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                child: const Center(child: CircularProgressIndicator()));
          }
          return _buildContactItems();
        },
      ),
    );
  }

  Widget _buildContactItems() {
    return Column(
      children: [
        ContactItem(
          iconPath: Assets.phone,
          title: AppLocalizations.current.phoneNumber,
          value:
              '${_cubit.profileDataEntity.countryCode} ${_cubit.profileDataEntity.phoneNumber}',
        ),
        SizedBox(height: 20),
        ContactItem(
          iconPath: Assets.email,
          title: AppLocalizations.current.email,
          value: _cubit.profileDataEntity.email,
        ),
        SizedBox(height: 20),
        ContactItem(
          iconPath: Assets.birthday,
          title: AppLocalizations.current.birthdayDate,
          value: DateFormat('dd/MM/yyyy').format(
            _cubit.profileDataEntity.burthdayDate,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ProfileButtonCard(
          text: AppLocalizations.current.myPages,
          onTap: () => NavigatorHelper.push(const MyPagesScreen()),
        ),
        ProfileButtonCard(
          text: AppLocalizations.current.changePassword,
          onTap: _openChangePasswordDialog,
        ),
        ProfileButtonCard(
          text: AppLocalizations.current.settings,
          onTap: () {},
        ),
        ProfileButtonCard(
          text: AppLocalizations.current.logout,
          textColor: Theme.of(context).appColors.red,
          onTap: _openLogoutDialog,
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _cubit.profileImage = File(image!.path);
    await _cubit.uploadProfileImage();
  }

  void _openEditDialog() {
    _fristNameController.text = _cubit.profileDataEntity.firstName;
    _lastNameController.text = _cubit.profileDataEntity.lastName;
    _phoneNumberController.text = _cubit.profileDataEntity.phoneNumber;
    _birthdayDateController.text = DateFormat('dd/MM/yyyy').format(
      _cubit.profileDataEntity.burthdayDate,
    );

    context.alertDialog(
      AppLocalizations.current.editInfo,
      AppLocalizations.current.update,
      AppLocalizations.current.cancel,
      () {
        if (_editDataFormKey.currentState?.validate() ?? false) {
          if (_cubit.profileDataEntity.firstName != _fristNameController.text ||
              _cubit.profileDataEntity.lastName != _lastNameController.text ||
              _cubit.profileDataEntity.phoneNumber !=
                  _phoneNumberController.text ||
              DateFormat('dd/MM/yyyy').format(
                    _cubit.profileDataEntity.burthdayDate,
                  ) !=
                  _birthdayDateController.text) {
            _cubit.editProfileData(
              firstName: _fristNameController.text,
              lastName: _lastNameController.text,
              countryCode: _cubit.profileDataEntity.countryCode,
              phoneNumber: _phoneNumberController.text,
              birthdayDate:
                  DateFormat('dd/MM/yyyy').parse(_birthdayDateController.text),
            );
          }
          Navigator.of(context).pop();
        }
      },
      () => Navigator.of(context).pop(),
      Form(
        key: _editDataFormKey,
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

  void _openChangePasswordDialog() {
    context.alertDialog(
      AppLocalizations.current.changePassword,
      AppLocalizations.current.update,
      AppLocalizations.current.cancel,
      () {
        if (_changePasswordFormKey.currentState?.validate() ?? false) {
          _cubit.changePassword(
            oldPassword: _oldpassController.text,
            newPassword: _newpassController.text,
          );
          _oldpassController.clear();
          _newpassController.clear();
          _cnewpassController.clear();
          Navigator.of(context).pop();
        }
      },
      () => Navigator.of(context).pop(),
      Form(
        key: _changePasswordFormKey,
        child: Column(
          children: [
            CustomTextField(
              labelText: AppLocalizations.current.addOldPassword,
              controller: _oldpassController,
              isPassword: true,
              validator: Validators.passwordValidator,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: AppLocalizations.current.addNewPassword,
              controller: _newpassController,
              isPassword: true,
              validator: Validators.passwordValidator,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: AppLocalizations.current.confirmNewPassword,
              controller: _cnewpassController,
              isPassword: true,
              validator: (vlaue) => Validators.confirmPasswordValidator(
                  vlaue, _newpassController.text),
            ),
          ],
        ),
      ),
    );
  }

  void _openLogoutDialog() {
    context.alertDialog(
        AppLocalizations.current.logout,
        AppLocalizations.current.cancel,
        AppLocalizations.current.logout,
        () => NavigatorHelper.pop(), () {
      _cubit.logout();
      NavigatorHelper.pop();
    },
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              SvgPicture.asset(
                Assets.logoutPlaceholder,
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.current.logoutMessage,
                style: Theme.of(context).appTexts.bodyMedium.copyWith(
                      color: Theme.of(context).appColors.black87,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ));
  }
}
