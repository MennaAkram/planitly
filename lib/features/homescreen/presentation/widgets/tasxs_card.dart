import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:planitly/design_system/theme.dart';

bool state = false;

class tasks extends StatefulWidget {
  final String task;
  const tasks({super.key, required this.task});

  @override
  State<tasks> createState() => _tasksState();
}

class _tasksState extends State<tasks> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 118,
        width: 150,
        child: Card(
            color: Theme.of(context).appColors.blue,
            child: ListTile(
                title: Row(children: [
                  Checkbox(
                    activeColor: Theme.of(context).appColors.green,
                    value: state,
                    onChanged: (val) {
                      setState(() {
                        state = val!;
                      });
                    },
                  ),
                  Text(widget.task,
                      style: Theme.of(context).appTexts.bodyLarge.copyWith(
                          color: Theme.of(context).appColors.white100))
                ]),
                subtitle: CircularPercentIndicator(
                  radius: 30.0,
                  lineWidth: 5.0,
                  percent: 1.0,
                  center: state == true
                      ? const Text(
                          "100%",
                          style: TextStyle(color: Color(0xffFFFFFF)),
                        )
                      : new Text(
                          "0%",
                          style: Theme.of(context).appTexts.bodyLarge.copyWith(
                            color: Theme.of(context).appColors.white100
                          ),
                        ),
                  progressColor: state == true
                      ? Theme.of(context).appColors.green
                      :Theme.of(context).appColors.white100,
                ))));
  }
}
