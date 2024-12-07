import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class TaskWidget extends StatefulWidget {
  final String task;
  final bool checked;
  final int progress;

  const TaskWidget(
      {super.key, required this.task, this.checked = false, this.progress = 0});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Checkbox(
                value: _checked,
                onChanged: (value) {
                  setState(() {
                    _checked = value!;
                  });
                },
                activeColor: Theme.of(context).appColors.primary,
                checkColor: Theme.of(context).appColors.white100,
                side: BorderSide(
                  color: Theme.of(context).appColors.black60,
                  width: 2,
                ),
              ),
            ),
            Expanded(
              child: Text(
                widget.task,
                style: Theme.of(context).appTexts.labelLarge.copyWith(
                      color: Theme.of(context).appColors.black87,
                    ),
              ),
            ),
          ]),
          const SizedBox(height: 16),
          Container(
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: Theme.of(context).appColors.secondary,
            alignment: Alignment.centerLeft,
            child: Container(
              width: widget.progress / 100 * MediaQuery.of(context).size.width - 16,
              decoration: BoxDecoration(
                gradient: Theme.of(context).appColors.gradientLR,
              ),
            ),
          )
        ],
      ),
    );
  }
}
