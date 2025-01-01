import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/provider/calendar_provider.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/screen/create_concert_page.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/calendar.dart';
import 'package:orchestra_rehearsal_scheduler/utils/strings.dart';
import 'package:orchestra_rehearsal_scheduler/widgets/auth_guard.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends ConsumerState<CalendarPage> {
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
    final entries =
        ref.watch(getCalendarEntriesProvider(month: month, year: year));

    return AuthGuard(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          centerTitle: false,
          title: (Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                capitalize(
                  DateFormat.yMMMM('es').format(DateTime(year, month)),
                ),
                style: const TextStyle(fontSize: 20),
              ),
              entries.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : Container()
            ],
          )),
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
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreateConcertPage(),
            ));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
