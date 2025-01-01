import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/domain/calendar_response.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/provider/calendar_provider.dart';

class DayPage extends ConsumerWidget {
  final int day;
  final int month;
  final int year;

  const DayPage({
    super.key,
    required this.day,
    required this.month,
    required this.year,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(
        getCalendarDateEntriesProvider(month: month, year: year, day: day));

    final List<Event> data = entries.maybeWhen(
      data: (data) => data.data,
      orElse: () => [],
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat.yMMMMd('es').format(DateTime(year, month, day))),
            if (entries.isLoading)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
          ],
        ),
      ),
      body: data.isEmpty
          ? const Center(child: Text('No events for this day'))
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final event = data[index];
                return ListTile(
                  leading: Text(
                    DateFormat.Hm().format(event.date),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Text(event.description),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add event action
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
