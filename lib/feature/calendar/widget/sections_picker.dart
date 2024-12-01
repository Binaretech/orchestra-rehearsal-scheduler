import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/provider/calendar_provider.dart';
import 'package:orchestra_rehearsal_scheduler/widgets/list_checkbox.dart';
import 'package:orchestra_rehearsal_scheduler/feature/calendar/data/model/section.dart';

class SectionsPicker extends ConsumerWidget {
  final Map<Section, bool> sectionValues;
  final ValueChanged<Map<Section, bool>> onSectionChanged;

  const SectionsPicker({
    super.key,
    required this.sectionValues,
    required this.onSectionChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familiesProviderResult = ref.watch(getFamiliesProvider);
    final updatedValues = Map<Section, bool>.from(sectionValues);

    return familiesProviderResult.when(
      data: (value) => Column(
        children: value.families.map((family) {
          if (family.sections.length == 1) {
            final section = family.sections.first;
            return Padding(
              padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
              child: Row(
                children: [
                  Checkbox(
                    tristate: true,
                    value: updatedValues[section] ?? false,
                    onChanged: (bool? newValue) {
                      updatedValues[section] = newValue ?? false;
                      onSectionChanged(updatedValues);
                    },
                  ),
                  Expanded(
                    child: Text(
                      section.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return ListCheckbox(
            topLabel: family.name,
            items: family.sections.map((section) => section.name).toList(),
            indented: true,
            values: family.sections
                .map((section) => updatedValues[section] ?? false)
                .toList(),
            onSelectionChanged: (selectedValues) {
              for (int i = 0; i < family.sections.length; i++) {
                updatedValues[family.sections[i]] = selectedValues[i];
              }
              onSectionChanged(updatedValues);
            },
          );
        }).toList(),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
    );
  }
}
