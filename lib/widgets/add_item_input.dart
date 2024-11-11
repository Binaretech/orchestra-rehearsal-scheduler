import 'package:flutter/material.dart';

class AddItemInput extends StatelessWidget {
  final List<String> values;
  final Function(List<String>) onAdd;

  final InputDecoration? decoration;

  final textController = TextEditingController();

  AddItemInput({
    super.key,
    this.values = const [],
    required this.onAdd,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: textController,
                decoration: decoration,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  onAdd([...values, textController.text]);
                  textController.clear();
                }
              },
            ),
          ],
        ),
        Wrap(
          children: values
              .map((piece) => Chip(
                  label: Text(piece),
                  onDeleted: () {
                    onAdd(
                      values.where((e) => e != piece).toList(),
                    );
                  }))
              .toList(),
        ),
      ],
    );
  }
}
