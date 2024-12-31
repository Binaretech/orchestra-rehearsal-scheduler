import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/calendar_response.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/provider/calendar_provider.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/day.dart';

class CalendarGrid extends ConsumerWidget {
  final int month;
  final int year;

  const CalendarGrid({super.key, required this.month, required this.year});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries =
        ref.watch(getCalendarEntriesProvider(month: month, year: year));

    final startDate = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstDayOfWeek = startDate.weekday;
    final lastDayOfWeek = DateTime(year, month, daysInMonth).weekday;

    final prevMonthDays = firstDayOfWeek - 1;
    final nextMonthDays = 7 - lastDayOfWeek;
    final totalItems = prevMonthDays + daysInMonth + nextMonthDays;

    final Map<String, List<Event>> data = entries.when(
      data: (data) => data.data,
      loading: () => {},
      error: (error, stackTrace) => {},
    );

    return LayoutBuilder(
      builder: (context, constraints) {
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
              final prevMonthDate = DateTime(year, month)
                  .subtract(Duration(days: prevMonthDays - index));
              return Day(
                day: prevMonthDate.day,
                year: prevMonthDate.year,
                month: prevMonthDate.month,
                isPadding: true,
              );
            } else if (index < prevMonthDays + daysInMonth) {
              final day = index - prevMonthDays + 1;

              final events = data['$year-$month-$day'] ?? [];

              return Day(day: day, year: year, month: month, events: events);
            } else {
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
