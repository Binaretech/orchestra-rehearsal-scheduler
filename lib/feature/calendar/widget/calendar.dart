import 'package:flutter/material.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/calendar_grid.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/calendar_header.dart';

const int pageSize = 10000;

class Calendar extends StatefulWidget {
  final Function(int month, int year) onChange;

  const Calendar({
    super.key,
    required this.onChange,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final int initialMonth = DateTime.now().month;
  final int initialYear = DateTime.now().year;

  final PageController _pageController = PageController(initialPage: pageSize);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    final int diff = index - pageSize;

    DateTime newDate = DateTime(initialYear, initialMonth + diff);

    widget.onChange(newDate.month, newDate.year);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          const CalendarHeader(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                final int diff = index - pageSize;

                DateTime newDate = DateTime(initialYear, initialMonth + diff);

                return CalendarGrid(
                  month: newDate.month,
                  year: newDate.year,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
