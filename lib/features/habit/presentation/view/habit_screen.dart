import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/habit/presentation/cubit/habit_operations.dart';
import 'package:planitly/features/habit/presentation/widgets/dialog.dart';
import 'package:planitly/features/habit/presentation/widgets/month_calendar.dart';
import 'package:planitly/features/habit/presentation/widgets/switch.dart';
import 'package:planitly/features/habit/presentation/widgets/habit.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:planitly/shared/widgets/calendar.dart';
import 'package:planitly/shared/widgets/fab_button.dart';

class HabitTrackerScreen extends StatefulWidget {
  const HabitTrackerScreen({super.key});

  @override
  State<HabitTrackerScreen> createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends State<HabitTrackerScreen> {
  final HabitsOP _habits = HabitsOP();
  DateTime? _selectedDate;
  DateTime? _selectedMonth;
  bool _isSelected = true;

  @override
  void initState() {
    _selectedDate = DateTime.now();
    _selectedMonth = DateTime.now();
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomAppBar(title: "Habit Tracker"),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).appColors.white100,
                  border: Border.all(
                    color: Theme.of(context).appColors.secondary,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).appColors.secondary,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                                onTap: () => {
                                      setState(() {
                                        _isSelected = true;
                                      })
                                    },
                                child: CustomSwitch(
                                    title: "Day", isSelected: _isSelected)),
                          ),
                          Expanded(
                            child: InkWell(
                                onTap: () => {
                                      setState(() {
                                        _isSelected = false;
                                      })
                                    },
                                child: CustomSwitch(
                                    title: "Month", isSelected: !_isSelected)),
                          ),
                        ],
                      ),
                    ),
                    AnimatedContainer(
                      curve: Curves.easeOutBack,
                      duration: const Duration(milliseconds: 300),
                      child: _isSelected
                          ? CalendarWidget(
                              currentDate: _selectedDate!,
                              onDateSelected: (selectedDate) => {
                                setState(() {
                                  _selectedDate = selectedDate;
                                }),
                              },
                            )
                          : MonthCalendar(
                              currentMonth: _selectedMonth!,
                              onDateSelected: (selectedMonth) => {
                                setState(() {
                                  _selectedMonth = selectedMonth;
                                }),
                              },
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              _habits.isEmpty(_isSelected ? _selectedDate! : _selectedMonth!,
                      compareBy: _isSelected ? null : "month")
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                          child: Column(
                        children: [
                          Image.asset(
                              "assets/images/undraw_healthy_habit_kwe6.png"),
                          const SizedBox(
                            height: 16,
                          ),
                          Text("Add your first habit",
                              style: Theme.of(context)
                                  .appTexts
                                  .bodyLarge
                                  .copyWith(
                                    color: Theme.of(context).appColors.black87,
                                  ))
                        ],
                      )),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ..._habits
                              .getHabits(
                                  date: _isSelected
                                      ? _selectedDate!
                                      : _selectedMonth!,
                                  compareBy: _isSelected ? "day" : "month")
                              .map((habit) {
                            return HabitWidget(
                              habit: habit,
                              onUpdate: ({double? progress, bool? checked, List<Task>? tasks}) {
                                setState(() {
                                  _habits.updateHabit(
                                    habit.id,
                                    checked: checked,
                                    progress: progress,
                                    tasks: tasks,
                                  );
                                });
                              },
                            );
                          }),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: AddButton(
        onPressed: () async {
          final result = await showDialog<String>(
            context: context,
            barrierDismissible: false,
            builder: (context) => const CustomDialog(),
          );
          if (result != null) {
            setState(() {
              _habits.addHabit(date: _selectedDate, habit: result);
            });
          }
        },
      ),
    );
  }
}
