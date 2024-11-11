import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConcertInfoForm extends StatefulWidget {
  final Function(
    String title,
    List<String> repertoire,
    Set<String> sections,
    Map<String, Set<String>> selectedInstruments,
    bool isDefinitive,
    DateTime? selectedDate,
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
  String currentPiece = '';
  Set<String> sections = {};

  static const Map<String, Set<String>> instruments = {
    'Cuerdas': {'Violín 1', 'Violín 2', 'Viola', 'Cello', 'Contrabajo'},
    'Madera': {'Flauta', 'Oboe', 'Clarinete', 'Fagot'},
    'Metales': {'Trompeta', 'Trombón', 'Tuba', 'Trompa'},
  };
  Map<String, Set<String>> selectedInstruments = {
    'Cuerdas': {},
    'Madera': {},
    'Metales': {},
  };

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
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Agregar pieza'),
                  onChanged: (value) {
                    currentPiece = value;
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (currentPiece.isNotEmpty) {
                    setState(() {
                      repertoire.add(currentPiece);
                      currentPiece = '';
                    });
                  }
                },
              ),
            ],
          ),
          Wrap(
            children: repertoire
                .map((piece) => Chip(
                      label: Text(piece),
                      onDeleted: () {
                        setState(() {
                          repertoire.remove(piece);
                        });
                      },
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          const Text(
            'Secciones Convocadas',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          ...instruments.keys.map((section) {
            return ExpansionTile(
              title: Row(
                children: [
                  Checkbox(
                    value: sections.contains(section),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          sections.add(section);
                          selectedInstruments[section] =
                              Set.from(instruments[section]!);
                        } else {
                          sections.remove(section);
                          selectedInstruments[section]?.clear();
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    section,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              initiallyExpanded: sections.contains(section),
              children: instruments[section]!
                  .map((instrument) => CheckboxListTile(
                        title: Text(instrument),
                        value:
                            selectedInstruments[section]!.contains(instrument),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedInstruments[section]!.add(instrument);
                            } else {
                              selectedInstruments[section]!.remove(instrument);
                            }
                            if (selectedInstruments[section]!.length ==
                                instruments[section]!.length) {
                              sections.add(section);
                            } else {
                              sections.remove(section);
                            }
                          });
                        },
                      ))
                  .toList(),
            );
          }),
          CheckboxListTile(
            title: const Text('Percusión'),
            value: sections.contains('Percusión'),
            contentPadding: const EdgeInsets.only(left: 21),
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  sections.add('Percusión');
                } else {
                  sections.remove('Percusión');
                }
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
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
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                widget.onSubmit(
                  title,
                  repertoire,
                  sections,
                  selectedInstruments,
                  isDefinitive,
                  selectedDate,
                );
              }
            },
            child: const Text('Siguiente'),
          ),
        ],
      ),
    );
  }
}
