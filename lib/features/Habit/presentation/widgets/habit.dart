import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Habit/presentation/cubit/habit_operations.dart';
import 'package:planitly/features/Habit/presentation/view/habit_tasks_screen.dart';
import 'package:planitly/shared/navigator_helper.dart';

class HabitWidget extends StatefulWidget {
  final Habit habit;
  final void Function({double? progress, bool? checked, List<Task>? tasks})? onUpdate;

  const HabitWidget({
    super.key,
    required this.habit,
    this.onUpdate,
  });

  @override
  State<HabitWidget> createState() => _HabitWidgetState();
}

class _HabitWidgetState extends State<HabitWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        NavigatorHelper.push(
          HabitTasksScreen(habit: widget.habit,onUpdate: widget.onUpdate),
        ),
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.only(right: 8, left: 8, bottom: 16, top: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).appColors.white100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).appColors.secondary,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(children: [
              Checkbox(
                value: widget.habit.checked,
                onChanged: (value) {
                  if (widget.onUpdate != null) {
                    setState(() {
                      widget.habit.updateProgress(allChecked: value);
                    });
                    widget.onUpdate!(checked: value,progress: widget.habit.progress);
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
                  widget.habit.habit,
                  style: Theme.of(context).appTexts.labelLarge.copyWith(
                        color: Theme.of(context).appColors.black87,
                      ),
                ),
              ),
            ]),
            const SizedBox(height: 8),
            Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: Theme.of(context).appColors.secondary,
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: widget.habit.progress,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: Theme.of(context).appColors.gradientLR,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
