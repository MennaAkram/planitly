import 'package:flutter/material.dart';
import 'package:planitly/design_system/app_colors.dart';
import 'package:planitly/design_system/app_text.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: const EdgeInsets.symmetric(vertical: 24),
      color: AppColorsTheme.light().white100,
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: CalendarFormat.month,
        daysOfWeekHeight: 35.46,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorsTheme.light().secondary,
            ),
            child: Icon(
              Icons.chevron_left,
              color: AppColorsTheme.light().white87,
            ),
          ),
          rightChevronIcon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColorsTheme.light().secondary,
            ),
            child: Icon(
              Icons.chevron_right,
              color: AppColorsTheme.light().white87,
            ),
          ),
          titleTextStyle: AppTextsTheme.main().bodyMedium.copyWith(
                color: AppColorsTheme.light().black60,
              ),
          headerPadding: EdgeInsets.zero,
          headerMargin: const EdgeInsets.only(top: 10, bottom: 24),
          rightChevronPadding: const EdgeInsets.symmetric(horizontal: 2),
          leftChevronPadding: const EdgeInsets.symmetric(horizontal: 2),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: AppTextsTheme.main().bodyLarge.copyWith(
              color: AppColorsTheme.light().black60,
              overflow: TextOverflow.visible),
          weekendStyle: AppTextsTheme.main().bodyLarge.copyWith(
              color: AppColorsTheme.light().black60,
              overflow: TextOverflow.visible),
          dowTextFormatter: (date, locale) =>
              DateFormat.E(locale).format(date)[0].toUpperCase(),
        ),
        calendarStyle: CalendarStyle(
          cellMargin: const EdgeInsets.all(10),
          defaultTextStyle: AppTextsTheme.main().bodyMedium.copyWith(
                color: AppColorsTheme.light().black60,
              ),
          outsideTextStyle: AppTextsTheme.main().bodyMedium.copyWith(
                color: AppColorsTheme.light().black16,
              ),
          weekendTextStyle: AppTextsTheme.main().bodyMedium.copyWith(
                color: AppColorsTheme.light().black60,
              ),
          todayTextStyle: AppTextsTheme.main().bodyMedium.copyWith(
                color: AppColorsTheme.light().white100,
              ),
          selectedTextStyle: AppTextsTheme.main().bodyMedium.copyWith(
                color: AppColorsTheme.light().black60,
              ),
          selectedDecoration: BoxDecoration(
            color: AppColorsTheme.light().secondary,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: AppColorsTheme.light().primary,
            shape: BoxShape.circle,
          ),
        ),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update focusedDay too
          });
        },
        onFormatChanged: (format) {
          setState(() {
            // Optionally handle format change
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
