import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RehearsalDaysForm extends StatefulWidget {
  final Function(List<DateTime>) onSubmit;
  final Function onBack;
  final DateTime performanceDate;

  const RehearsalDaysForm({
    super.key,
    required this.onSubmit,
    required this.onBack,
    required this.performanceDate,
  });

  @override
  RehearsalDaysFormState createState() => RehearsalDaysFormState();
}

class RehearsalDaysFormState extends State<RehearsalDaysForm> {
  DateTime? _startDate;
  TimeOfDay? _rehearsalTime;
  final Set<int> _selectedWeekdays = {};
  final List<DateTime> _rehearsalDays = [];
  bool _isRecurring = true;

  Future<void> _selectStartDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: widget.performanceDate,
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _rehearsalTime ?? const TimeOfDay(hour: 19, minute: 0),
    );
    if (picked != null) {
      setState(() {
        _rehearsalTime = picked;
      });
    }
  }

  void _generateRehearsalDays() {
    if (_startDate != null && _rehearsalTime != null) {
      if (_isRecurring && _selectedWeekdays.isNotEmpty) {
        DateTime currentDate = _startDate!;
        while (!currentDate.isAfter(widget.performanceDate)) {
          if (_selectedWeekdays.contains(currentDate.weekday)) {
            DateTime rehearsalDate = DateTime(
              currentDate.year,
              currentDate.month,
              currentDate.day,
              _rehearsalTime!.hour,
              _rehearsalTime!.minute,
            );
            if (!_rehearsalDays.contains(rehearsalDate)) {
              _rehearsalDays.add(rehearsalDate);
            }
          }
          currentDate = currentDate.add(const Duration(days: 1));
        }
      } else if (!_isRecurring) {
        DateTime rehearsalDate = DateTime(
          _startDate!.year,
          _startDate!.month,
          _startDate!.day,
          _rehearsalTime!.hour,
          _rehearsalTime!.minute,
        );
        if (!_rehearsalDays.contains(rehearsalDate)) {
          _rehearsalDays.add(rehearsalDate);
        }
      }
      setState(() {
        _rehearsalDays.sort();
      });
    }
  }

  Widget _buildStartDateSelector() {
    return ListTile(
      title: const Text(
        'Fecha de Inicio',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        _startDate == null
            ? 'Seleccione la fecha de inicio'
            : DateFormat('EEEE, d MMMM yyyy').format(_startDate!),
      ),
      trailing: const Icon(Icons.calendar_today),
      onTap: _selectStartDate,
    );
  }

  Widget _buildTimeSelector() {
    return ListTile(
      title: const Text(
        'Hora del Ensayo',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        _rehearsalTime == null
            ? 'Seleccione la hora del ensayo'
            : _rehearsalTime!.format(context),
      ),
      trailing: const Icon(Icons.access_time),
      onTap: _selectTime,
    );
  }

  Widget _buildRehearsalTypeSelector() {
    return SwitchListTile(
      title: const Text(
        'Ensayo Recurrente',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      value: _isRecurring,
      onChanged: (bool value) {
        setState(() {
          _isRecurring = value;
        });
      },
    );
  }

  Widget _buildWeekdaySelector() {
    final weekdays = [
      {'name': 'Lunes', 'value': DateTime.monday},
      {'name': 'Martes', 'value': DateTime.tuesday},
      {'name': 'Miércoles', 'value': DateTime.wednesday},
      {'name': 'Jueves', 'value': DateTime.thursday},
      {'name': 'Viernes', 'value': DateTime.friday},
      {'name': 'Sábado', 'value': DateTime.saturday},
      {'name': 'Domingo', 'value': DateTime.sunday},
    ];

    return Visibility(
      visible: _isRecurring,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Días de la Semana',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: weekdays.map((day) {
              final isSelected = _selectedWeekdays.contains(day['value']);
              return ChoiceChip(
                label: Text(day['name']!.toString()),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedWeekdays.add(day['value'] as int);
                    } else {
                      _selectedWeekdays.remove(day['value'] as int);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRehearsalDaysList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fechas de Ensayo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _rehearsalDays.isEmpty
            ? const Text('No hay fechas de ensayo generadas.')
            : Column(
                children: _rehearsalDays.map((date) {
                  return ListTile(
                    title: Text(
                      DateFormat('EEEE, d MMMM yyyy', 'es').format(date),
                    ),
                    subtitle: Text(
                      'Hora: ${DateFormat('hh:mm a').format(date)}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _rehearsalDays.remove(date);
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
      ],
    );
  }

  void _onGenerateDates() {
    if (_startDate == null ||
        _rehearsalTime == null ||
        (_isRecurring && _selectedWeekdays.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Por favor, complete todos los campos antes de generar las fechas.'),
        ),
      );
    } else {
      _generateRehearsalDays();

      setState(() {
        _startDate = null;
        _rehearsalTime = null;
        _selectedWeekdays.clear();
      });
    }
  }

  void _onSubmit() {
    if (_rehearsalDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay fechas de ensayo seleccionadas.'),
        ),
      );
    } else {
      widget.onSubmit(_rehearsalDays);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStartDateSelector(),
        const Divider(),
        _buildTimeSelector(),
        const Divider(),
        _buildRehearsalTypeSelector(),
        const Divider(),
        _buildWeekdaySelector(),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.calendar_today),
          label: const Text('Agregar'),
          onPressed: _onGenerateDates,
        ),
        const Divider(),
        _buildRehearsalDaysList(),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => widget.onBack(),
              child: const Text('Atrás'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _onSubmit,
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ],
    );
  }
}
