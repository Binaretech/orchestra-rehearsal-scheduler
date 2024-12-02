import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/widget/sections_picker.dart';
import 'package:orchestra_rehearsal_scheduler/feature/sections/data/model/section.dart';
import 'package:orchestra_rehearsal_scheduler/widgets/add_item_input.dart';

class ConcertInfoForm extends StatefulWidget {
  final void Function(
    String title,
    List<String> repertoire,
    Set<Section> selectedSections,
    bool isDefinitive,
    DateTime selectedDate,
  ) onSubmit;

  const ConcertInfoForm({
    super.key,
    required this.onSubmit,
  });

  @override
  ConcertInfoFormState createState() => ConcertInfoFormState();
}

class ConcertInfoFormState extends State<ConcertInfoForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String title = '';
  List<String> repertoire = [];
  Map<Section, bool> selectedSections = {};
  bool isDefinitive = false;
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration:
                const InputDecoration(labelText: 'Título del Concierto'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa el título del concierto';
              }
              return null;
            },
            onSaved: (value) {
              title = value ?? '';
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Repertorio',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          AddItemInput(
            decoration: const InputDecoration(labelText: 'Agregar pieza'),
            onAdd: (values) {
              setState(() {
                repertoire = values;
              });
            },
            values: repertoire,
          ),
          const SizedBox(height: 16),
          const Text(
            'Secciones Convocadas',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SectionsPicker(
            sectionValues: selectedSections,
            onSectionChanged: (updatedValues) {
              setState(() {
                selectedSections = Map<Section, bool>.from(updatedValues);
              });
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Fecha del Concierto',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Expanded(
                child: Text(selectedDate == null
                    ? 'No se ha seleccionado ninguna fecha'
                    : DateFormat('dd/MM/yyyy').format(selectedDate!)),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Fecha Definitiva'),
            value: isDefinitive,
            onChanged: (bool value) {
              setState(() {
                isDefinitive = value;
              });
            },
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: formKey.currentState?.validate() == true
                ? () {
                    formKey.currentState!.save();
                    widget.onSubmit(
                      title,
                      repertoire,
                      selectedSections.keys
                          .where((section) => selectedSections[section] == true)
                          .toSet(),
                      isDefinitive,
                      selectedDate ?? DateTime.now(),
                    );
                  }
                : null,
            child: const Text('Siguiente'),
          ),
        ],
      ),
    );
  }
}
