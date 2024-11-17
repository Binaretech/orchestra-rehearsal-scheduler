import 'package:flutter/material.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/day.dart';

class CalendarGrid extends StatelessWidget {
  final int month;
  final int year;

  const CalendarGrid({super.key, required this.month, required this.year});

  @override
  Widget build(BuildContext context) {
    final startDate = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstDayOfWeek = startDate.weekday;
    final lastDayOfWeek = DateTime(year, month, daysInMonth).weekday;

    final prevMonthDays = firstDayOfWeek - 1;
    final nextMonthDays = 7 - lastDayOfWeek;
    final totalItems = prevMonthDays + daysInMonth + nextMonthDays;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate the height for each cell by dividing the available height by the number of weeks
        final itemHeight = (constraints.maxHeight / ((totalItems / 7).ceil()));
        final itemWidth = constraints.maxWidth / 7;

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: itemWidth / itemHeight,
          ),
          itemCount: totalItems,
          itemBuilder: (context, index) {
            if (index < prevMonthDays) {
              // Show previous month's days as padding
              final prevMonthDate = DateTime(year, month)
                  .subtract(Duration(days: prevMonthDays - index));
              return Day(
                day: prevMonthDate.day,
                year: prevMonthDate.year,
                month: prevMonthDate.month,
                isPadding: true,
              );
            } else if (index < prevMonthDays + daysInMonth) {
              // Show current month's days
              final day = index - prevMonthDays + 1;
              return Day(day: day, year: year, month: month);
            } else {
              // Show next month's days as padding
              final nextMonthDate = DateTime(year, month + 1)
                  .add(Duration(days: index - prevMonthDays - daysInMonth));
              return Day(
                day: nextMonthDate.day,
                year: nextMonthDate.year,
                month: nextMonthDate.month,
                isPadding: true,
              );
            }
          },
        );
      },
    );
  }
}
