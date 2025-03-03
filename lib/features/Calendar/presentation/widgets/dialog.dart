import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Calendar/presentation/widgets/dialog_button.dart';
import 'package:planitly/shared/widgets/drop_down_list.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final Map<String, String?> _selectedValues = {
    "firstItem": 'Me',
    "secondItem": 'items',
    "relation": 'relation',
  };

  Widget _selectorField(String key, String title, String hintText,
      List<String> menuItems, BuildContext context,
      {double offset = 1}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).appTexts.labelSmall.copyWith(
                  color: Theme.of(context).appColors.black87,
                ),
          ),
          const SizedBox(height: 8.0),
          DropDownList(
              hintText: _selectedValues[key] ?? hintText,
              menuItems: menuItems,
              offset: offset,
              onItemSelected: (value) {
                setState(() {
                  _selectedValues[key] = value;
                });
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).appColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add new connection",
                style: Theme.of(context).appTexts.titleSmall.copyWith(
                      color: Theme.of(context).appColors.black87,
                    ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  _selectorField(
                      "firstItem",
                      "First item",
                      "Me",
                      [
                        'Me',
                        'Study',
                        'Business',
                        'Bro',
                        'Team',
                        'Gym',
                        'Movie',
                        'Someone',
                        'Exam'
                      ],
                      offset: 27,
                      context),
                  const SizedBox(width: 16.0),
                  _selectorField(
                      "secondItem",
                      "Secound item",
                      "items",
                      [
                        'Me',
                        'Study',
                        'Business',
                        'Bro',
                        'Team',
                        'Gym',
                        'Movie',
                        'Someone',
                        'Exam'
                      ],
                      context)
                ],
              ),
              const SizedBox(height: 16.0),
              Row(children: [
                _selectorField("relation", "relation between them", "relation",
                    ['Do', 'Goes To', 'Watch', 'Meet'], context)
              ]),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: CustomDialogButton(
                      text: "Add",
                      onPressed: () {
                        Navigator.of(context).pop(_selectedValues);
                      },
                      outlined: false,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: CustomDialogButton(
                      text: "Cancel",
                      onPressed: () => Navigator.of(context).pop(),
                      outlined: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
