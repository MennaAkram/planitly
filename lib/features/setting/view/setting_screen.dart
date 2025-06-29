import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:flutter/material.dart';
import 'package:planitly/features/setting/widget/pages.dart';
import 'package:planitly/generated/l10n.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:planitly/shared/widgets/extensions.dart';
import '../../../app/di.dart';
import '../../../shared/navigator_helper.dart';
import '../../../shared/widgets/drop_down_list.dart';
import '../../categories/presentation/cubit/categories_cubit.dart';
import '../widget/setting_buttom.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  bool status = false;
  String checked = 'No Page Shared';
  final CategoriesCubit _cubit = getIt.get<CategoriesCubit>();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<String> tags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildProfileAppBar(),
      backgroundColor: Theme.of(context).appColors.white100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).appColors.white100,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(
                      color: Theme.of(context).appColors.black16, width: 0.5)),
              child: ListTile(
                title: Text(
                  "Theme",
                  style: Theme.of(context).appTexts.bodyMedium.copyWith(
                        color: Theme.of(context).appColors.black87,
                      ),
                ),
                trailing: Switch(
                  inactiveThumbColor: Theme.of(context).appColors.black37,
                  activeColor: Theme.of(context).appColors.white100,
                  activeTrackColor: Theme.of(context).appColors.primary,
                  value: status,
                  onChanged: (val) {
                    setState(() {
                      status = val;
                    });
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text("which pages can ai access",
                  style: Theme.of(context).appTexts.labelMedium.copyWith(
                        color: Theme.of(context).appColors.black87,
                      )),
            ),
            Container(
                alignment: Alignment.center,
                margin:EdgeInsets.only(top: 8,bottom: 16,left: 16,right: 16),
                padding: EdgeInsets.only(bottom: 20),
                height: 92,
                decoration: BoxDecoration(
                    color: Theme.of(context).appColors.white100,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    border: Border.all(
                        color: Theme.of(context).appColors.black16,
                        width: 0.5)),
                child: Column(
                  children: [
                    Expanded(
                        child: RadioListTile(
                      value: 'No Page Shared',
                      groupValue: checked,
                      onChanged: (val) {
                        setState(() {
                          checked = val!;
                        });
                      },
                      contentPadding: EdgeInsets.all(8),
                      activeColor: Theme.of(context).appColors.primary,
                      title: Text("No Page Shared",
                          style: Theme.of(context).appTexts.bodySmall.copyWith(
                                color: Theme.of(context).appColors.black87,
                              )),
                    )),
                    Expanded(
                        child: RadioListTile(
                      value: 'Only Share...',
                      groupValue: checked,
                      onChanged: (val)  {
                        _openAddPageDialog();
                          setState(() {
                            checked = val!;
                          });
                      },
                      contentPadding: EdgeInsets.all(8),
                      activeColor: Theme.of(context).appColors.primary,
                      title: Text("Only Share...",
                          style: Theme.of(context).appTexts.bodySmall.copyWith(
                                color: Theme.of(context).appColors.black87,
                              )),
                    )),
                  ],
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text("Who logged In your account",
                  style: Theme.of(context).appTexts.labelMedium.copyWith(
                        color: Theme.of(context).appColors.black87,
                      )),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text("Tap a devices to logout",
                  style: Theme.of(context).appTexts.labelSmall.copyWith(
                        color: Theme.of(context).appColors.black87,
                      )),
            ),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                decoration: BoxDecoration(
                    color: Theme.of(context).appColors.white100,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    border: Border.all(
                        color: Theme.of(context).appColors.black16,
                        width: 0.5)),
                child: Column(
                  children: [
                    SettingButtom(
                        text: "macOS",
                        iconPath: Assets.labIcon,
                        onTap: () => _openLogoutDialog(context),
                        address: 'Cairo, Egypt today at 3:55 AM'),
                    SettingButtom(
                        text: "Vivo V25e",
                        iconPath: Assets.mobleIcon,
                        onTap: () => _openLogoutDialog(context),
                        address: 'Cairo, Egypt today at 3:55 AM'),
                    SettingButtom(
                        text: "macOS",
                        iconPath: Assets.labIcon,
                        onTap: () => _openLogoutDialog(context),
                        address: 'Cairo, Egypt today at 3:55 AM'),
                    SettingButtom(
                        text: "Vivo V25e",
                        iconPath: Assets.mobleIcon,
                        onTap: () => _openLogoutDialog(context),
                        address: 'Cairo, Egypt today at 3:55 AM'),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  CustomAppBar _buildProfileAppBar() {
    return CustomAppBar(
      title: AppLocalizations.current.settings,
    );
  }
void _openLogoutDialog(BuildContext context) {
  context.alertDialog(
      AppLocalizations.current.deviceLogout,
      AppLocalizations.current.cancel,
      AppLocalizations.current.logout,
          () => NavigatorHelper.pop(),
          () {
        //todo
        // _cubit.logout();
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
              "Are you sure, you want to logout from this device?",
              style: Theme
                  .of(context)
                  .appTexts
                  .bodyMedium
                  .copyWith(
                color: Theme
                    .of(context)
                    .appColors
                    .black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ));
}

  void _openAddPageDialog() {
    context.alertDialog(
      AppLocalizations.of(context).shareWithAi,
      AppLocalizations.of(context).share,
      AppLocalizations.current.cancel,
          () {
        if (tags.isNotEmpty) {
          Navigator.of(context).pop(tags);
        }
      },
          () {
        nameController.clear();
        _cubit.selectedPages.clear();
        Navigator.of(context).pop();
      },
      StatefulBuilder(
        builder: (context, setState) => Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select pages to share with AI",
                style: Theme.of(context).appTexts.labelSmall.copyWith(
                  color: Theme.of(context).appColors.black87,
                ),
              ),
              const SizedBox(height: 8),
              DropDownList(
                hintText: "Select page",
                menuItems: const ["Gym", "Work", "Study"],
                onItemSelected: (value) {
                  if (!tags.contains(value)) {
                    setState(() {
                      tags.add(value);
                    });
                  }
                },
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: tags.map((tag) {
                  return RemovableTag(
                    label: tag,
                    onRemove: () {
                      setState(() {
                        tags.remove(tag);
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
