import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:flutter/material.dart';
import 'package:planitly/features/setting/widget/pages.dart';
import 'package:planitly/generated/l10n.dart';
import 'package:planitly/shared/assets.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:planitly/shared/widgets/button.dart';
import '../../../shared/widgets/drop_down_list.dart';
import '../widget/setting_buttom.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  bool status = false;
  String checked = 'No Page Shared';

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
              height: 49,
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
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                      onChanged: (val) async {
                        final selectedTags = await showDialog(
                          context: context,
                          builder: (context) => CustomDialog(),
                        );
                        if (selectedTags != null && selectedTags.isNotEmpty) {
                          setState(() {
                            checked = val!;
                          });
                        }
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
                margin: EdgeInsets.all(16),
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
}

void _openLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Device logout",
                  style: Theme.of(context).appTexts.titleSmall.copyWith(
                        color: Theme.of(context).appColors.black87,
                      )),
            ),
            const SizedBox(height: 8),
            SvgPicture.asset(
              Assets.logoutPlaceholder,
            ),
            const SizedBox(height: 16),
            Text(
              "Are you sure, you want to logout from this device?",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).appColors.black87,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Wrap(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Expanded(
                      child: CustomButton(
                          text: "Cancel",
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          outlined: false)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Expanded(
                    child: CustomButton(
                        text: "Logout",
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        outlined: true),
                  ),
                )
              ],
            ),
          ],
        ),
        backgroundColor: Theme.of(context).appColors.white100,
      );
    },
  );
}

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final List<String> tags = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).appColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Share With AI",
              style: Theme.of(context).appTexts.titleSmall.copyWith(
                    color: Theme.of(context).appColors.black87,
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Text(
                "Select pages to share with AI",
                style: Theme.of(context).appTexts.labelSmall.copyWith(
                      color: Theme.of(context).appColors.black87,
                    ),
              ),
            ),
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
            const SizedBox(height: 8),
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Share",
                    onPressed: () {
                      if (tags.isNotEmpty) {
                        Navigator.of(context).pop(tags);
                      } else {}
                    },
                    outlined: false,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: "Cancel",
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    outlined: true,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
