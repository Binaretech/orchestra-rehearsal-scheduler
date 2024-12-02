import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orchestra_rehearsal_scheduler/feature/sections/widgets/section_musicians_list_view.dart';
import 'package:orchestra_rehearsal_scheduler/feature/users/data/model/user.dart';

class SectionMusicianPicker extends StatelessWidget {
  final String label;
  final ValueChanged<User> onSelect;
  final int sectionId;

  const SectionMusicianPicker({
    super.key,
    required this.label,
    required this.onSelect,
    required this.sectionId,
  });
  Future<void> _showUserSelectionDialog(BuildContext context) async {
    User? selectedMusician = await showDialog<User>(
      context: context,
      builder: (BuildContext context) {
        return MusiciansDialog(
          sectionId: sectionId,
          onTap: (User user) {
            Navigator.of(context).pop(user);
          },
        );
      },
    );

    if (selectedMusician != null) {
      onSelect(selectedMusician);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showUserSelectionDialog(context),
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}

class MusiciansDialog extends ConsumerStatefulWidget {
  final int sectionId;
  final void Function(User)? onTap;

  const MusiciansDialog({super.key, required this.sectionId, this.onTap});

  @override
  MusiciansDialogState createState() => MusiciansDialogState();
}

class MusiciansDialogState extends ConsumerState<MusiciansDialog> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: AlertDialog(
        title: const Text('Seleccionar Músico'),
        content: SizedBox(
          width: double.maxFinite,
          height: 500,
          child: SectionMusiciansListView(
            sectionId: widget.sectionId,
            onTap: widget.onTap,
          ),
        ),
      ),
    );
  }
}
