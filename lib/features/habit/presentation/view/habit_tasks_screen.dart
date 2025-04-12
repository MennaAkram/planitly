import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/habit/presentation/widgets/task.dart';
import 'package:planitly/features/habit/presentation/widgets/tasks_dialog.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:planitly/features/habit/presentation/cubit/habit_operations.dart';
import 'package:planitly/shared/widgets/fab_button.dart';

class HabitTasksScreen extends StatefulWidget {
  final Habit habit;
  final void Function({double? progress, bool? checked, List<Task>? tasks})? onUpdate;

  const HabitTasksScreen({super.key, required this.habit, this.onUpdate});

  @override
  State<HabitTasksScreen> createState() => _HabitTasksScreenState();
}

class _HabitTasksScreenState extends State<HabitTasksScreen> {
  late Habit habit;

  @override
  void initState() {
    habit = widget.habit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).appColors.background,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomAppBar(title: habit.habit),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: habit.tasks
                      .map((task) => TaskWidget(
                            task: task,
                            onChecked: ({checked}) {
                              setState(() {
                                habit.updateTask(task.id, checked!);
                              });
                              widget.onUpdate!(
                                  tasks: habit.tasks,
                                  progress: habit.progress,
                                  checked: habit.checked);
                            },
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: AddButton(onPressed: () async {
        final result = await showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (context) => const HabitTasksDialog(),
        );

        if (result != null) {
          setState(() {
            habit.addTask(result);
          });
          widget.onUpdate!(
              tasks: habit.tasks,
              progress: habit.progress,
              checked: habit.checked);
        }
      }),
    );
  }
}
