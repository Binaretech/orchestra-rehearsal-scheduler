import 'package:flutter/material.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/data/model/section.dart';

class MusiciansForm extends StatefulWidget {
  final Set<Section> sections;
  final Function onBack;
  final Function(Map<Section, List<List<String>>>) onSubmit;

  const MusiciansForm({
    super.key,
    required this.sections,
    required this.onBack,
    required this.onSubmit,
  });

  @override
  MusiciansFormState createState() => MusiciansFormState();
}

class MusiciansFormState extends State<MusiciansForm> {
  Map<Section, List<List<String>>> selectedMusicians = {};

  void _addMusicStand(Section section) {
    if (!selectedMusicians.containsKey(section)) {
      setState(() {
        selectedMusicians[section] = [];
      });
    }
    setState(() {
      selectedMusicians[section]!.add(['', '']);
    });
  }

  void _removeMusicStand(Section section, int index) {
    if (selectedMusicians[section] != null &&
        selectedMusicians[section]!.length > index) {
      setState(() {
        selectedMusicians[section]!.removeAt(index);
      });
    }
  }

  Widget _buildInstrumentMusicians(Section section) {
    List<Widget> musicStandWidgets = [];
    for (int index = 0;
        index < (selectedMusicians[section]?.length ?? 0);
        index++) {
      musicStandWidgets.add(
        _buildMusicStandRow(section, index, selectedMusicians[section]![index]),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(section.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ...musicStandWidgets,
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _addMusicStand(section),
          child: const Text('Agregar Atril'),
        ),
      ],
    );
  }

  Widget _buildMusicStandRow(
      Section section, int index, List<String> musicStand) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration:
                InputDecoration(labelText: 'Músico Atril ${index + 1} - 1'),
            initialValue: musicStand[0],
            onChanged: (value) {
              if (selectedMusicians[section] != null &&
                  selectedMusicians[section]!.length > index) {
                setState(() {
                  selectedMusicians[section]![index][0] = value;
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
                  selectedMusicians[section]!.length > index) {
                setState(() {
                  selectedMusicians[section]![index][1] = value;
                });
              }
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle),
          onPressed: () => _removeMusicStand(section, index),
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
          return _buildInstrumentMusicians(section);
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
