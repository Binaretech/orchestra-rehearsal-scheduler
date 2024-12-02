import 'package:flutter/material.dart';
import 'package:orchestra_rehearsal_scheduler/feature/sections/data/model/section.dart';
import 'package:orchestra_rehearsal_scheduler/feature/users/data/model/user.dart';

class ConvertReview extends StatelessWidget {
  final String title;
  final List<String> repertoire;
  final Set<Section> sections;
  final bool isDefinitive;
  final Map<Section, List<List<User>>> selectedMusicians;
  final DateTime? performanceDate;
  final List<DateTime> rehearsalDays;
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  const ConvertReview({
    super.key,
    required this.title,
    required this.repertoire,
    required this.sections,
    required this.isDefinitive,
    required this.selectedMusicians,
    required this.performanceDate,
    required this.rehearsalDays,
    required this.onBack,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
        _buildSectionTitle('Repertorio:'),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children:
              repertoire.map((piece) => Chip(label: Text(piece))).toList(),
        ),
        const SizedBox(height: 16.0),
        _buildSectionTitle('Secciones Involucradas:'),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: sections
              .map((section) => Chip(label: Text(section.name)))
              .toList(),
        ),
        const SizedBox(height: 16.0),
        _buildSectionTitle('Días de Ensayo:'),
        if (rehearsalDays.isNotEmpty)
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: rehearsalDays
                .map((day) => Chip(label: Text(_formatDate(day))))
                .toList(),
          ),
        if (performanceDate != null) ...[
          const SizedBox(height: 16.0),
          _buildSectionTitle('Fecha de la Presentación:'),
          Text(_formatDate(performanceDate!)),
        ],
        const SizedBox(height: 16.0),
        _buildSectionTitle('Revisión Definitiva:'),
        Text(isDefinitive ? 'Sí' : 'No'),
        const SizedBox(height: 16.0),
        _buildSectionTitle('Músicos:'),
        _buildMusiciansWithNumbering(),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => onBack(),
              child: const Text('Atrás'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: onSubmit,
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  Widget _buildMusiciansWithNumbering() {
    List<Widget> musicianWidgets = [];

    // Iterate over the sections
    selectedMusicians.forEach((section, musicStands) {
      // Add the section name as a header
      musicianWidgets.add(
        Text(
          section.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      );

      for (int i = 0; i < musicStands.length; i++) {
        var musicStand = musicStands[i];
        musicianWidgets.add(
          Text(
            'Atril ${i + 1}: ${musicStand.map((user) => user.fullname).join(', ')}',
          ),
        );
      }

      musicianWidgets
          .add(const SizedBox(height: 8.0)); // Add spacing between sections
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: musicianWidgets,
    );
  }
}
