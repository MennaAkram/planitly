import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key, required this.startDate, required this.endDate});

  final DateTime startDate;
  final DateTime endDate;

  @override
  State<Calendar> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<Calendar> {
  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;
  late DateTime _focusedDay;

  @override
  void initState() {
    log("Start date: ${widget.startDate}, End date: ${widget.endDate}");
    super.initState();
    _selectedStartDate = widget.startDate;
    _selectedEndDate = widget.endDate;
    _focusedDay = widget.startDate;
  }

  bool _isBetweenDates(DateTime day) {
    return (day.isAfter(_selectedStartDate) && day.isBefore(_selectedEndDate)) ||
        day.isAtSameMomentAs(_selectedStartDate) ||
        day.isAtSameMomentAs(_selectedEndDate);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedStartDate.isBefore(_selectedEndDate)) {
        _selectedEndDate = selectedDay.isAfter(_selectedStartDate) ? selectedDay : _selectedStartDate;
      } else {
        _selectedStartDate = selectedDay.isBefore(_selectedEndDate) ? selectedDay : _selectedEndDate;
      }
      _focusedDay = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(day, _selectedStartDate) || isSameDay(day, _selectedEndDate);
        },
        onDaySelected: _onDaySelected,
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          formatButtonShowsNext: true,
          formatButtonDecoration: BoxDecoration(
            color: Theme.of(context).appColors.secondary,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, date, _) {
            if (_isBetweenDates(date)) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).appColors.secondary, // Light green
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            }
            return null;
          },
        ),
        calendarStyle: CalendarStyle(
          isTodayHighlighted: false,
          weekendTextStyle: TextStyle(color: Theme.of(context).appColors.black37),
          selectedDecoration: BoxDecoration(
            color: Theme.of(context).appColors.primary,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}