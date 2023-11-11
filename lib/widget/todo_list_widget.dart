import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/widget/todo_list_item_widget.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.todos, required this.onLongPress, required this.onCompletedChanged, required this.onDelete});

  final List<Todo> todos;
  final void Function(Todo) onLongPress;
  final void Function(Todo) onCompletedChanged;
  final void Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: todos.map((todo) => TodoListItem(
        todo: todo,
        onLongPressCallback: onLongPress,
        onCompletedChangedCallback: onCompletedChanged,
        onDeleteCallback: onDelete,
      )).toList(),
    );
  }

}