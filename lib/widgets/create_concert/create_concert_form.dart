import 'package:flutter/material.dart';
import 'package:orchestra_rehearsal_scheduler/widgets/create_concert/concert_info_form.dart';
import 'package:orchestra_rehearsal_scheduler/widgets/create_concert/musicians_form.dart';

class CreateConcertForm extends StatefulWidget {
  const CreateConcertForm({super.key});

  @override
  CreateConcertFormState createState() => CreateConcertFormState();
}

class CreateConcertFormState extends State<CreateConcertForm> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;

  Set<String> sections = {};
  Map<String, Set<String>> selectedInstruments = {};

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void onSubmit(
    Map<String, Map<String, List<List<String>>>> selectedMusicians,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Concierto creado con éxito')),
    );
  }

  void onBack() {
    setState(() {
      currentStep = 0;
    });
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
      currentStep = 1;
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
            onSubmit: onSubmit,
          ),
        ),
      ],
    );
  }
}
