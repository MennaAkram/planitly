import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:intl/intl.dart';

class MonthCalendar extends StatefulWidget {
  final void Function(DateTime selectedDate)? onDateSelected;
  final DateTime currentMonth;

  const MonthCalendar({super.key, this.onDateSelected, required this.currentMonth});

  @override
  State<MonthCalendar> createState() => _MonthCalendarState();
}

class _MonthCalendarState extends State<MonthCalendar> {
  String? _selectedMonth;
  final List<List<Map<String, String>>> _months = [
    [
      {"Jan": "January"},
      {"Feb": "February"},
      {"Mar": "March"},
      {"Apr": "April"}
    ],
    [
      {"May": "May"},
      {"Jun": "June"},
      {"Jul": "July"},
      {"Aug": "August"}
    ],
    [
      {"Sep": "September"},
      {"Oct": "October"},
      {"Nov": "November"},
      {"Dec": "December"}
    ]
  ];

  @override
  void initState() {
    _selectedMonth = DateFormat('MMMM yyyy').format(widget.currentMonth);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appColors.white100,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  _selectedMonth!,
                  style: Theme.of(context).appTexts.bodyMedium.copyWith(
                        color: Theme.of(context).appColors.black60,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: _months.map((monthRow) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: monthRow.map((month) {
                        return Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedMonth = _selectedMonth!.replaceFirst(
                                    RegExp(r'^\w+'), month.values.first);
                              });
                              if (widget.onDateSelected != null) {
                                widget.onDateSelected!(DateFormat('MMMM yyyy').parse(_selectedMonth!));
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                              margin: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: _selectedMonth!.substring(0, 3) ==
                                        month.keys.first
                                    ? Theme.of(context).appColors.primary
                                    : Theme.of(context).appColors.secondary,
                                border: Border.all(
                                  color: _selectedMonth!.substring(0, 3) ==
                                          month.keys.first
                                      ? Theme.of(context).appColors.primary
                                      : Theme.of(context).appColors.secondary,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Center(
                                child: Text(month.keys.first,
                                    style: Theme.of(context)
                                        .appTexts
                                        .labelLarge
                                        .copyWith(
                                          color:
                                              _selectedMonth!.substring(0, 3) ==
                                                      month.keys.first
                                                  ? Theme.of(context)
                                                      .appColors
                                                      .white100
                                                  : Theme.of(context)
                                                      .appColors
                                                      .black87,
                                        )),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ))
          ],
        ),
      ),
    );
  }
}
