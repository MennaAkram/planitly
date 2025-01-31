import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:planitly/design_system/theme.dart';

bool state = false;

class Habits extends StatefulWidget {
  final String habit;
  const Habits({super.key, required this.habit});

  @override
  State<Habits> createState() => _HabitsState();
}

class _HabitsState extends State<Habits> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 118,
        width: 150,
        child: Card(
            color: Theme.of(context).appColors.secondary,
            child: ListTile(
                title: Row(children: [
                  Checkbox(
                    activeColor: Theme.of(context).appColors.primary,
                    value: state,
                    onChanged: (val) {
                      setState(() {
                        state = val!;
                      });
                    },
                  ),
                  Text(widget.habit,
                      style: Theme.of(context)
                          .appTexts
                          .bodyLarge
                          .copyWith(color: Theme.of(context).appColors.black87))
                ]),
                subtitle: new CircularPercentIndicator(
                  radius: 30.0,
                  lineWidth: 5.0,
                  percent: 1.0,
                  center: state == true ? const Text("100%") : const Text("0%"),
                  progressColor: state == true
                      ? Theme.of(context).appColors.primary
                      : Theme.of(context).appColors.white100,
                ))));
  }
}
