import 'package:flutter/material.dart';
import 'package:orchestra_rehearsal_scheduler/feature/sections/data/model/section.dart';
import 'package:orchestra_rehearsal_scheduler/feature/sections/widgets/section_musicians_picker.dart';
import 'package:orchestra_rehearsal_scheduler/feature/users/data/model/user.dart';

class MusiciansForm extends StatefulWidget {
  final Set<Section> sections;
  final Function onBack;
  final Function(Map<Section, List<List<User>>>) onSubmit;

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
  Map<Section, List<List<User?>>> selectedMusicians = {};

  void _addMusicStand(Section section) {
    if (!selectedMusicians.containsKey(section)) {
      setState(() {
        selectedMusicians[section] = [];
      });
    }
    setState(() {
      selectedMusicians[section]!.add([null, null]);
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
        FilledButton.tonal(
          onPressed: () => _addMusicStand(section),
          child: const Text('Agregar Atril'),
        ),
      ],
    );
  }

  Widget _buildMusicStandRow(
      Section section, int index, List<User?> musicStand) {
    return Row(
      children: [
        Expanded(
          child: SectionMusicianPicker(
            sectionId: section.id,
            label: musicStand[0] == null
                ? 'Seleccionar Músico 1'
                : musicStand[0]!.fullname,
            onSelect: (selectedMusician) {
              setState(() {
                selectedMusicians[section]![index][0] = selectedMusician;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SectionMusicianPicker(
            sectionId: section.id,
            label: musicStand[1] == null
                ? 'Seleccionar Músico 2'
                : musicStand[1]!.fullname,
            onSelect: (selectedMusician) {
              setState(() {
                selectedMusicians[section]![index][1] = selectedMusician;
              });
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

  void _submitForm() {
    Map<Section, List<List<User>>> filteredMusicians = {};

    selectedMusicians.forEach((section, musicStands) {
      filteredMusicians[section] = musicStands
          .map((musicStand) => [
                if (musicStand[0] != null) musicStand[0]!,
                if (musicStand[1] != null) musicStand[1]!,
              ])
          .toList();
    });

    widget.onSubmit(filteredMusicians);
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
              onPressed: _submitForm,
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ],
    );
  }
}
