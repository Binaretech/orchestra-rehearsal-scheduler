import 'package:flutter/material.dart';

class ListCheckbox extends StatelessWidget {
  final List<String> items;
  final List<bool>? values;
  final String topLabel;
  final bool indented;
  final ValueChanged<List<bool>>? onSelectionChanged;

  const ListCheckbox({
    super.key,
    required this.items,
    this.values,
    this.topLabel = 'Select All',
    this.indented = false,
    this.onSelectionChanged,
  });

  bool? _getTopLevelCheckedState() {
    if (values == null || values!.isEmpty) return false;
    if (values!.every((value) => value)) return true;
    if (values!.every((value) => !value)) return false;
    return null;
  }

  void _notifySelectionChanged(BuildContext context, List<bool> updatedValues) {
    if (onSelectionChanged != null) {
      onSelectionChanged!(updatedValues);
    }
  }

  @override
  Widget build(BuildContext context) {
    final topLevelChecked = _getTopLevelCheckedState();

    return ExpansionTile(
      title: Row(
        children: [
          Checkbox(
            tristate: true,
            value: topLevelChecked,
            onChanged: (_) {
              final isSelected = topLevelChecked != true;
              final newValues = List<bool>.filled(items.length, isSelected);
              _notifySelectionChanged(context, newValues);
            },
          ),
          Expanded(
            child: Text(topLabel),
          ),
        ],
      ),
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final isChecked = values?[index] ?? false;

            return Padding(
              padding: indented
                  ? const EdgeInsets.only(left: 32.0)
                  : EdgeInsets.zero,
              child: CheckboxListItem(
                label: item,
                value: isChecked,
                onChanged: (value) {
                  final updatedValues = List<bool>.from(
                      values ?? List<bool>.filled(items.length, false));
                  updatedValues[index] = value ?? false;
                  _notifySelectionChanged(context, updatedValues);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class CheckboxListItem extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxListItem({
    super.key,
    required this.label,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Expanded(
          child: Text(label),
        ),
      ],
    );
  }
}
