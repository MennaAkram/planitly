import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:planitly/design_system/theme.dart';

bool state = false;

class TodayTaskCard extends StatefulWidget {
  final String task;
  final bool isHabit;

  const TodayTaskCard({super.key, required this.task, this.isHabit = false});

  @override
  State<TodayTaskCard> createState() => _TodayTaskCardState();
}

class _TodayTaskCardState extends State<TodayTaskCard> {
  bool _habit = false;

  @override
  void initState() {
    super.initState();
    _habit = widget.isHabit;
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 118,
        width: 150,
        child: Card(
          elevation: 0,
            color: _habit ? Theme.of(context).appColors.secondary :
            Theme.of(context).appColors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child:
                Column(
                  children: [
                    Row(children: [
                      Checkbox(
                        side: BorderSide(color: Theme.of(context).appColors.white100, width: 2),
                        activeColor: _habit ? Theme.of(context).appColors.primary :
                        Theme.of(context).appColors.green,
                        value: state,
                        onChanged: (val) {
                          setState(() {
                            state = val!;
                          });
                        },
                      ),
                      Text(widget.task,
                          style: Theme.of(context).appTexts.bodyLarge.copyWith(
                              color: _habit? Theme.of(context).appColors.black87 : Theme.of(context).appColors.white100))
                    ]),
                CircularPercentIndicator(
                  radius: 25.0,
                  lineWidth: 5.0,
                  percent: 1.0,
                  center: state == true
                      ?  Text(
                          "100%",
                          style: Theme.of(context).appTexts.bodySmall.copyWith(
                              color: _habit? Theme.of(context).appColors.black87 : Theme.of(context).appColors.white100
                          ),

                        )
                      : new Text(
                          "0%",
                          style: Theme.of(context).appTexts.bodySmall.copyWith(
                            color: _habit? Theme.of(context).appColors.black87 : Theme.of(context).appColors.white100
                          ),
                        ),
                  progressColor: state == true
                      ? (_habit ? Theme.of(context).appColors.primary : Theme.of(context).appColors.green)
                      : Theme.of(context).appColors.white100,
                )
                  ],
                ),
            ));
  }
}
