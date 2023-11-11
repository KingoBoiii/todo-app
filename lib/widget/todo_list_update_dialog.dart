import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoListUpdateDialog extends StatelessWidget {
  TodoListUpdateDialog({super.key, required this.todo, required this.onUpdate});

  final void Function(Todo) onUpdate;

  final Todo todo;
  final TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textFieldController.text = todo.text;

    return AlertDialog(
      title: const Text('Update todo task'),
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
          label: const Text('Close'), 
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton.icon(
          icon: const Icon(Icons.update),
          label: const Text('Update'), 
          onPressed: () { 
            if(textFieldController.text.isEmpty) {
              return;
            }

            todo.text = textFieldController.text;
            onUpdate.call(todo);
            textFieldController.text = '';

            Navigator.of(context).pop();
          },
        )
      ]
    );
  }
}