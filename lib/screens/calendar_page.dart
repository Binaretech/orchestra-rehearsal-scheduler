import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orchestra_rehearsal_scheduler/widgets/calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  _onChange(int month, int year) {
    setState(() {
      this.month = month;
      this.year = year;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: false,
        title: Text(DateFormat.yMMMM().format(DateTime(year, month))),
      ),
      body: Column(
        children: [
          Expanded(
            child: Calendar(
              onChange: _onChange,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // You can navigate to the page to add an event
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
