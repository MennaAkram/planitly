import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/profile/presentation/widget/change_pop_screen.dart';
import 'package:planitly/features/profile/presentation/widget/contact_item.dart';
import 'package:planitly/features/profile/presentation/widget/edit_pop_screen.dart';
import 'package:planitly/features/profile/presentation/widget/logout_pop_screen.dart';
import 'package:planitly/features/profile/presentation/widget/profile_button.dart';
import 'package:planitly/shared/assets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController fristnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String fristname = 'Menna';
  String lastname = 'Akram';
  String Birthday = '1/1/1976';
  String phonenum = '01244539870';
  final TextEditingController oldpassController = TextEditingController();
  final TextEditingController newpassController = TextEditingController();
  final TextEditingController cnewpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        titleTextStyle: Theme.of(context)
            .appTexts
            .titleSmall
            .copyWith(color: Theme.of(context).appColors.black87),
        actions: [
          IconButton(
              onPressed: () => showEditPopup(context, () {
                    setState(() {
                      fristname = fristnameController.text;
                      lastname = lastnameController.text;
                      Birthday = birthdayController.text;
                      phonenum = phoneController.text;
                    });
                  }, fristnameController, lastnameController, phoneController,
                      birthdayController),
              icon: SvgPicture.asset(Assets.edit))
        ],
      ),
      backgroundColor: Theme.of(context).appColors.white100,
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
            value: phonenum,
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
            value: Birthday,
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
}
