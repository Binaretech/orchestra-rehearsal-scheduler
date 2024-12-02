import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/concert_info_form.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/convert_review.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/musicians_form.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/rehearshal_day_form.dart';
import 'package:orchestra_rehearsal_scheduler/feature/sections/data/model/section.dart';
import 'package:orchestra_rehearsal_scheduler/feature/users/data/model/user.dart';

class CreateConcertForm extends StatefulWidget {
  const CreateConcertForm({super.key});

  @override
  CreateConcertFormState createState() => CreateConcertFormState();
}

class CreateConcertFormState extends State<CreateConcertForm> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;

  String title = '';
  List<String> repertoire = [];
  Set<Section> sections = {};
  bool isDefinitive = false;

  Map<Section, List<List<User>>> selectedMusicians = {};
  DateTime performanceDate = DateTime.now();
  List<DateTime> rehearsalDays = [];

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void onNext() {
    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Concierto creado con éxito')),
    );
  }

  void onBack() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void onSubmitConcertInfo(String title, List<String> repertoire,
      Set<Section> sections, bool isDefinitive, DateTime selectedDate) {
    setState(() {
      this.title = title;
      this.repertoire = repertoire;
      this.isDefinitive = isDefinitive;

      this.sections = sections;
      performanceDate = selectedDate;
      onNext();
    });
  }

  void onSubmitMusicians(Map<Section, List<List<User>>> selectedMusicians) {
    setState(() {
      this.selectedMusicians = selectedMusicians;
    });
    onNext();
  }

  void onSubmitRehearshalDates(List<DateTime> rehearsalDays) {
    setState(() {
      this.rehearsalDays = rehearsalDays;
    });

    onNext();
  }

  void onSubmit() {
    final data = {
      'title': title,
      'repertoire': repertoire,
      'isDefinitive': isDefinitive,
      'date': performanceDate.toIso8601String(),
      'rehearsalDays':
          rehearsalDays.map((date) => date.toUtc().toIso8601String()).toList(),
      'distribution': selectedMusicians.entries.map((entry) {
        return {
          'section': entry.key.id,
          'musicStands': entry.value.asMap().entries.map((stand) {
            return {
              'stand': stand.key + 1,
              'musicians': stand.value.map((musician) => musician.id).toList(),
            };
          }).toList(),
        };
      }).toList(),
    };

    print(jsonEncode(data));
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controlsBuilder: (context, details) => Container(),
      currentStep: currentStep,
      steps: [
        Step(
          title: const Text('Detalles del Concierto'),
          isActive: currentStep >= 0,
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          content: ConcertInfoForm(
            onSubmit: onSubmitConcertInfo,
          ),
        ),
        Step(
          title: const Text('Asignar Músicos'),
          isActive: currentStep >= 1,
          content: MusiciansForm(
            sections: sections,
            onBack: onBack,
            onSubmit: onSubmitMusicians,
          ),
        ),
        Step(
          title: const Text('Días de Ensayo'),
          isActive: currentStep >= 2,
          content: RehearsalDaysForm(
            performanceDate: performanceDate,
            onBack: onBack,
            onSubmit: onSubmitRehearshalDates,
          ),
        ),
        Step(
          title: const Text('Resumen'),
          isActive: currentStep >= 3,
          content: ConvertReview(
            title: title,
            repertoire: repertoire,
            sections: sections,
            isDefinitive: isDefinitive,
            selectedMusicians: selectedMusicians,
            performanceDate: performanceDate,
            rehearsalDays: rehearsalDays,
            onBack: onBack,
            onSubmit: onSubmit,
          ),
        )
      ],
    );
  }
}
