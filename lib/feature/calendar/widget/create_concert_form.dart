import 'package:flutter/material.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/concert_info_form.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/musicians_form.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/rehearshal_day_form.dart';

class CreateConcertForm extends StatefulWidget {
  const CreateConcertForm({super.key});

  @override
  CreateConcertFormState createState() => CreateConcertFormState();
}

class CreateConcertFormState extends State<CreateConcertForm> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;

  DateTime? performanceDate;
  Set<String> sections = {};
  Map<String, Set<String>> selectedInstruments = {};

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void onNext() {
    if (currentStep < 2) {
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

  void onSubmitInfo(
      String title,
      List<String> repertoire,
      Set<String> sections,
      Map<String, Set<String>> selectedInstruments,
      bool isDefinitive,
      DateTime? selectedDate) {
    setState(() {
      this.sections = sections;
      this.selectedInstruments = selectedInstruments;

      performanceDate = selectedDate;

      onNext();
    });
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
            onSubmit: onSubmitInfo,
          ),
        ),
        Step(
          title: const Text('Asignar Músicos'),
          isActive: currentStep >= 1,
          content: MusiciansForm(
            sections: sections,
            selectedInstruments: selectedInstruments,
            onBack: onBack,
            onSubmit: (a) {
              onNext();
            },
          ),
        ),
        Step(
          title: const Text('Días de Ensayo'),
          isActive: currentStep >= 2,
          content: RehearsalDaysForm(
            performanceDate: performanceDate ?? DateTime.now(),
            onBack: onBack,
            onSubmit: (a) {},
          ),
        )
      ],
    );
  }
}
