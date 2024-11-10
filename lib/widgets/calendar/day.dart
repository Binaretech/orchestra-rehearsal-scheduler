import 'package:flutter/material.dart';

class Day extends StatelessWidget {
  final int day;
  final int year;
  final int month;

  final bool isPadding;

  const Day({
    super.key,
    required this.day,
    required this.year,
    required this.month,
    this.isPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 6,
            left: 6,
            child: Text(
              day.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isPadding ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
