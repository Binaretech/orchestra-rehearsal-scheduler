import 'package:flutter/material.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/calendar_response.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/event_indicator.dart';

class Day extends StatelessWidget {
  final int day;
  final int year;
  final int month;

  final bool isPadding;
  final List<Event> events;

  const Day({
    super.key,
    required this.day,
    required this.year,
    required this.month,
    this.isPadding = false,
    this.events = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 80,
        maxHeight: 120,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              day.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isPadding ? Colors.grey : Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(
                left: 6,
                right: 6,
                bottom: 6,
              ),
              children: [
                ...events.take(3).map(
                      (event) => EventIndicator(event: event),
                    ),
                if (events.length > 3)
                  Text(
                    '+${events.length - 3}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade900,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
