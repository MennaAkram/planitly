import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
class HabitWidget extends StatefulWidget {
  final Map<String, dynamic> habit;
  final void Function(bool checked)? onChecked;

  const HabitWidget({
    super.key,
    required this.habit,
    this.onChecked,
  });

  @override
  State<HabitWidget> createState() => _HabitWidgetState();
}

class _HabitWidgetState extends State<HabitWidget> {


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
                value: widget.habit['checked'],
                onChanged: (value) {
                  if (widget.onChecked != null) {
                    widget.onChecked!(value!);
                  }
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
                widget.habit['habit'],
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
            child: FractionallySizedBox(
              widthFactor: widget.habit['progress'] / 100,
              child: Container(
                decoration: BoxDecoration(
                  gradient: Theme.of(context).appColors.gradientLR,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
