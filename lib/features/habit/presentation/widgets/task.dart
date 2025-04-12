import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/habit/presentation/cubit/habit_operations.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  final void Function({bool? checked})? onChecked;

  const TaskWidget({super.key, required this.task, this.onChecked});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.white100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).appColors.secondary,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: widget.task.checked,
                  onChanged: (value) {
                    if (widget.onChecked != null) {
                      widget.onChecked!(checked: value);
                    }
                  },
                  activeColor: Theme.of(context).appColors.primary,
                  checkColor: Theme.of(context).appColors.white100,
                  side: BorderSide(
                    color: Theme.of(context).appColors.black60,
                    width: 2,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.task.task,
                    style: Theme.of(context).appTexts.labelLarge.copyWith(
                        color: Theme.of(context).appColors.black87,
                        decoration: widget.task.checked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}
