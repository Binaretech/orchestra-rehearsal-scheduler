import 'package:flutter/material.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/calendar_response.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/contants.dart';

class EventIndicator extends StatelessWidget {
  final Event event;

  const EventIndicator({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (event.type) {
      case EventType.rehearsal:
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade900;
        break;
      case EventType.concert:
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade900;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "${event.type.name} - ${event.title}",
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 10,
          color: textColor,
        ),
      ),
    );
  }
}
