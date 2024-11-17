import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        final dayName =
            DateFormat.E().dateSymbols.SHORTWEEKDAYS[(index + 1) % 7];
        return Expanded(
          child: Center(
            child: Text(
              dayName,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
        );
      }),
    );
  }
}
