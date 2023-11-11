import 'package:flutter/material.dart';

class TodoListAddDialog extends StatelessWidget {
  TodoListAddDialog({super.key, required this.onAdd});

  final void Function(String) onAdd;

  final TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add todo task'),
      content: TextField(
        controller: textFieldController,
        maxLength: 50,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: <Widget>[
        TextButton.icon(
          style: const ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.redAccent)
          ),
          icon: const Icon(Icons.close),
          label: const Text('Don\'t add'), 
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add'), 
          onPressed: () { 
            if(textFieldController.text.isEmpty) {
              return;
            }

            onAdd.call(textFieldController.text);
            textFieldController.text = '';

            Navigator.of(context).pop();
          },
        )
      ]
    );
  }
}