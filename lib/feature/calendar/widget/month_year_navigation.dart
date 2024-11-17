import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthYearNavigation extends StatelessWidget {
  final int month;
  final int year;
  final Function(int, int) onMonthChanged;

  const MonthYearNavigation({
    super.key,
    required this.month,
    required this.year,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            if (month == 1) {
              onMonthChanged(12, year - 1);
            } else {
              onMonthChanged(month - 1, year);
            }
          },
        ),
        Text(
          DateFormat.yMMMM().format(DateTime(year, month)),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            // Avanzar un mes
            if (month == 12) {
              onMonthChanged(1, year + 1); // Cambiar al enero del año siguiente
            } else {
              onMonthChanged(month + 1, year);
            }
          },
        ),
      ],
    );
  }
}
