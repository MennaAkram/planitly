import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime currentDate;
  final IconData leftIcon;
  final IconData rightIcon;
  final void Function(DateTime selectedDate)? onDateSelected;

  const CalendarWidget({
    super.key,
    required this.currentDate,
    this.leftIcon = Icons.chevron_left,
    this.rightIcon = Icons.chevron_right,
    this.onDateSelected,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime? _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    _focusedDay = widget.currentDate;
    _selectedDay = widget.currentDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Theme.of(context).appColors.white100,
      child: TableCalendar(
        key: ValueKey(_selectedDay),
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay!,
        calendarFormat: CalendarFormat.month,
        daysOfWeekHeight: 35.46,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).appColors.secondary,
            ),
            child: Icon(
              widget.leftIcon,
              color: Theme.of(context).appColors.white87,
            ),
          ),
          rightChevronIcon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).appColors.secondary,
            ),
            child: Icon(
              widget.rightIcon,
              color: Theme.of(context).appColors.white87,
            ),
          ),
          titleTextStyle: Theme.of(context).appTexts.bodyMedium.copyWith(
                color: Theme.of(context).appColors.black60,
              ),
          headerPadding: EdgeInsets.zero,
          headerMargin: const EdgeInsets.only(top: 10, bottom: 24),
          rightChevronPadding: const EdgeInsets.symmetric(horizontal: 2),
          leftChevronPadding: const EdgeInsets.symmetric(horizontal: 2),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: Theme.of(context).appTexts.bodyLarge.copyWith(
                color: Theme.of(context).appColors.black60,
                overflow: TextOverflow.visible,
              ),
          weekendStyle: Theme.of(context).appTexts.bodyLarge.copyWith(
                color: Theme.of(context).appColors.black60,
                overflow: TextOverflow.visible,
              ),
          dowTextFormatter: (date, locale) =>
              DateFormat.E(locale).format(date)[0].toUpperCase(),
        ),
        calendarStyle: CalendarStyle(
          cellMargin: const EdgeInsets.all(10),
          defaultTextStyle: Theme.of(context).appTexts.bodyMedium.copyWith(
                color: Theme.of(context).appColors.black60,
              ),
          outsideTextStyle: Theme.of(context).appTexts.bodyMedium.copyWith(
                color: Theme.of(context).appColors.black16,
              ),
          weekendTextStyle: Theme.of(context).appTexts.bodyMedium.copyWith(
                color: Theme.of(context).appColors.black60,
              ),
          todayTextStyle: Theme.of(context).appTexts.bodyMedium.copyWith(
                color: _selectedDay != null
                    ? Theme.of(context).appColors.black60
                    : Theme.of(context).appColors.white100,
              ),
          selectedTextStyle: Theme.of(context).appTexts.bodyMedium.copyWith(
                color: Theme.of(context).appColors.white100,
              ),
          selectedDecoration: BoxDecoration(
            color: Theme.of(context).appColors.primary,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: _selectedDay != null
                ? Theme.of(context).appColors.background
                : Theme.of(context).appColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });

          if (widget.onDateSelected != null) {
            widget.onDateSelected!(selectedDay);
          }
        },
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },
      ),
    );
  }
}
