import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/widgets/button.dart';
import 'package:planitly/shared/widgets/text_field.dart';

class HabitTasksDialog extends StatefulWidget {
  const HabitTasksDialog({super.key});

  @override
  State<HabitTasksDialog> createState() => _HabitTasksDialogState();
}

class _HabitTasksDialogState extends State<HabitTasksDialog> {
  final TextEditingController _controller = TextEditingController();

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
              "Add task",
              style: Theme.of(context).appTexts.titleSmall.copyWith(
                    color: Theme.of(context).appColors.black87,
                  ),
            ),
            const SizedBox(height: 16),
            CustomTextField(labelText: "Add your task..", controller: _controller),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                        text: "Add",
                        onPressed: () {
                          Navigator.of(context).pop(_controller.text);
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
