import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.onLongPress, required this.onCheckboxChanged, required this.onDeletePress, required this.todos});
  
  final void Function(Todo todo) onLongPress;
  final void Function(Todo todo) onCheckboxChanged;
  final void Function(Todo todo) onDeletePress;
  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: buildTodoItem,
    );
  }

  Widget buildTodoItem(BuildContext context, int index) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      key: Key(todos[index].id),
      title: Text(todos[index].text),
      onLongPress: () => onLongPress(todos[index]),
      leading: Checkbox(
        onChanged: (newState) {
          todos[index].completed = newState ?? false;
          onCheckboxChanged(todos[index]);
        },
        value: todos[index].completed
      ),
      trailing: IconButton(
        onPressed: () => onDeletePress(todos[index]),
        color: Colors.redAccent,
        icon: const Icon(Icons.delete)
      )
    );
  }

}