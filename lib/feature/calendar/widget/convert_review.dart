import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orchestra_rehearsal_scheduler/feature/sections/data/model/section.dart';
import 'package:orchestra_rehearsal_scheduler/feature/users/data/model/user.dart';

class ConcertReview extends StatelessWidget {
  final String title;
  final List<String> repertoire;
  final Set<Section> sections;
  final bool isDefinitive;
  final Map<Section, List<List<User>>> selectedMusicians;
  final DateTime? performanceDate;
  final List<DateTime> rehearsalDays;
  final String location;
  final VoidCallback onBack;
  final VoidCallback? onSubmit;
  final bool isLoading;

  const ConcertReview({
    super.key,
    required this.title,
    required this.repertoire,
    required this.location,
    required this.sections,
    required this.isDefinitive,
    required this.selectedMusicians,
    required this.performanceDate,
    required this.rehearsalDays,
    required this.onBack,
    required this.onSubmit,
    this.isLoading = false,
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
        const Divider(),
        const SizedBox(height: 8.0),

        _buildSectionTitle('Repertorio'),
        const SizedBox(height: 8.0),
        if (repertoire.isNotEmpty)
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children:
                repertoire.map((piece) => Chip(label: Text(piece))).toList(),
          )
        else
          const Text('Sin repertorio.'),
        const SizedBox(height: 16.0),

        // Sections
        _buildSectionTitle('Secciones Involucradas'),
        const SizedBox(height: 8.0),
        if (sections.isNotEmpty)
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: sections
                .map((section) => Chip(label: Text(section.name)))
                .toList(),
          )
        else
          const Text('No se han seleccionado secciones.'),
        const SizedBox(height: 16.0),

        _buildSectionTitle('Días de Ensayo'),
        const SizedBox(height: 8.0),
        if (rehearsalDays.isNotEmpty)
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: rehearsalDays
                .map((day) => Chip(label: Text(_formatDate(day))))
                .toList(),
          )
        else
          const Text('No se han seleccionado días de ensayo.'),
        const SizedBox(height: 16.0),

        if (performanceDate != null) ...[
          _buildSectionTitle('Fecha de la Presentación'),
          const SizedBox(height: 8.0),
          Text(_formatDate(performanceDate!)),
          const SizedBox(height: 16.0),
        ],

        // Definitive Date
        _buildSectionTitle('Fecha Definitiva'),
        const SizedBox(height: 8.0),
        Text(isDefinitive ? 'Sí' : 'No'),
        const SizedBox(height: 16.0),

        // Location
        _buildSectionTitle('Lugar'),
        const SizedBox(height: 8.0),
        Text(location.isNotEmpty ? location : 'No se ha especificado lugar.'),
        const SizedBox(height: 16.0),

        // Musicians
        _buildSectionTitle('Músicos'),
        const SizedBox(height: 8.0),
        _buildMusiciansWithNumbering(),
        const SizedBox(height: 16.0),
        const Divider(),
        const SizedBox(height: 16.0),

        // Actions
        Row(
          children: [
            ElevatedButton(
              onPressed: onBack,
              child: const Text('Atrás'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              // Disable or replace with a loading indicator while isLoading
              onPressed: (isLoading || onSubmit == null) ? null : onSubmit,
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Siguiente'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String titleText) {
    return Text(
      titleText,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('EEEE, d MMMM yyyy hh:mm a', 'es').format(date);
  }

  Widget _buildMusiciansWithNumbering() {
    if (selectedMusicians.isEmpty) {
      return const Text('No se han asignado músicos.');
    }

    final List<Widget> musicianWidgets = [];

    selectedMusicians.forEach((section, musicStands) {
      musicianWidgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            section.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      );

      for (int i = 0; i < musicStands.length; i++) {
        final standMusicians = musicStands[i];
        final musicianNames =
            standMusicians.map((user) => user.fullname).join(', ');

        musicianWidgets.add(
          Text('Atril ${i + 1}: $musicianNames'),
        );
      }

      musicianWidgets.add(const SizedBox(height: 8.0));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: musicianWidgets,
    );
  }
}
