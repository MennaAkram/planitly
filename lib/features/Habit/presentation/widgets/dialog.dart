import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:planitly/shared/widgets/drop_down_list.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String? _selectedItem;

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
              "Add new habit",
              style: Theme.of(context).appTexts.titleSmall.copyWith(
                    color: Theme.of(context).appColors.black87,
                  ),
            ),
            const SizedBox(height: 16),
            DropDownList(
              hintText: "habit",
              menuItems: const ["Reading", "Writing", "Drawing", "TV"],
              onItemSelected: (value) => {
                setState(() {
                  _selectedItem = value;
                })
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                        text: "Add",
                        onPressed: () {
                          if (_selectedItem != null) {
                            Navigator.of(context).pop(_selectedItem);
                          }
                        },
                        outlined: false)),
                const SizedBox(width: 10),
                Expanded(
                    child: CustomButton(
                        text: "Cancle",
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        outlined: true))
              ],
            )
          ],
        ),
      ),
    );
  }
}
