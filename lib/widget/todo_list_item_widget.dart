import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({super.key, 
    required this.todo, 
    required this.onLongPressCallback, 
    required this.onCompletedChangedCallback, 
    required this.onDeleteCallback});

  final Todo todo;
  final void Function(Todo) onLongPressCallback;
  final void Function(Todo) onCompletedChangedCallback;
  final void Function(Todo) onDeleteCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(todo.id),
      title: Text(todo.text),
      leading: Checkbox(
        onChanged: (newState) {
          todo.completed = newState ?? false;
          onCompletedChangedCallback.call(todo);
        },
        value: todo.completed
      ),
      onLongPress: () => onLongPressCallback.call(todo),
      trailing: IconButton(
        onPressed: () => onDeleteCallback.call(todo),
        color: Colors.redAccent,
        icon: const Icon(Icons.delete)
      )
    );
  }

}