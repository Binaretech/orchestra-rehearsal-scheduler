import 'package:flutter/material.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/create_concert_form.dart';

class CreateConcertPage extends StatelessWidget {
  const CreateConcertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Concierto'),
      ),
      body: const CreateConcertForm(),
    );
  }
}
