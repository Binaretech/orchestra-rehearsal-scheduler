import 'package:flutter/material.dart';

class MusiciansForm extends StatefulWidget {
  final Set<String> sections;
  final Map<String, Set<String>> selectedInstruments;
  final Function onBack;
  final Function(Map<String, Map<String, List<List<String>>>>) onSubmit;

  const MusiciansForm({
    super.key,
    required this.sections,
    required this.selectedInstruments,
    required this.onBack,
    required this.onSubmit,
  });

  @override
  MusiciansFormState createState() => MusiciansFormState();
}

class MusiciansFormState extends State<MusiciansForm> {
  Map<String, Map<String, List<List<String>>>> selectedMusicians = {
    'Cuerdas': {},
    'Madera': {},
    'Metales': {},
    'Percusión': {},
  };

  void _addMusicStand(String section, String instrument) {
    if (!selectedMusicians[section]!.containsKey(instrument)) {
      setState(() {
        selectedMusicians[section]![instrument] = [];
      });
    }
    setState(() {
      selectedMusicians[section]![instrument]!.add(['', '']);
    });
  }

  void _removeMusicStand(String section, String instrument, int index) {
    if (selectedMusicians[section]![instrument] != null &&
        selectedMusicians[section]![instrument]!.length > index) {
      setState(() {
        selectedMusicians[section]![instrument]!.removeAt(index);
      });
    }
  }

  Widget _buildInstrumentMusicians(String section, String instrument) {
    List<Widget> musicStandWidgets = [];
    for (int index = 0;
        index < (selectedMusicians[section]?[instrument]?.length ?? 0);
        index++) {
      musicStandWidgets.add(
        _buildMusicStandRow(section, instrument, index,
            selectedMusicians[section]![instrument]![index]),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(instrument,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ...musicStandWidgets,
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _addMusicStand(section, instrument),
          child: const Text('Agregar Atril'),
        ),
      ],
    );
  }

  Widget _buildMusicStandRow(
      String section, String instrument, int index, List<String> musicStand) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration:
                InputDecoration(labelText: 'Músico Atril ${index + 1} - 1'),
            initialValue: musicStand[0],
            onChanged: (value) {
              if (selectedMusicians[section] != null &&
                  selectedMusicians[section]![instrument] != null &&
                  selectedMusicians[section]![instrument]!.length > index) {
                setState(() {
                  selectedMusicians[section]![instrument]![index][0] = value;
                });
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            decoration:
                InputDecoration(labelText: 'Músico Atril ${index + 1} - 2'),
            initialValue: musicStand[1],
            onChanged: (value) {
              if (selectedMusicians[section] != null &&
                  selectedMusicians[section]![instrument] != null &&
                  selectedMusicians[section]![instrument]!.length > index) {
                setState(() {
                  selectedMusicians[section]![instrument]![index][1] = value;
                });
              }
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle),
          onPressed: () => _removeMusicStand(section, instrument, index),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...widget.sections.map((section) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(section,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              ...widget.selectedInstruments[section]!.map((instrument) =>
                  _buildInstrumentMusicians(section, instrument)),
            ],
          );
        }),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FilledButton(
              onPressed: () => widget.onBack(),
              child: const Text('Atrás'),
            ),
            const SizedBox(width: 16),
            FilledButton(
              onPressed: () => widget.onSubmit(selectedMusicians),
              child: const Text('Siguiente'),
            ),
          ],
        )
      ],
    );
  }
}
