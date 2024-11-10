import 'package:flutter/material.dart';
import 'package:orchestra_rehearsal_scheduler/screens/calendar_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D1627)),
        useMaterial3: true,
      ),
      home: const CalendarPage(),
    );
  }
}
