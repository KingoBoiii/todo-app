import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_collection_model.dart';
import 'package:todo_app/views/todo_collection/todo/todo_screen.dart';

class TodoCollectionList extends StatelessWidget {
  const TodoCollectionList({super.key, required this.onLongPress, required this.onDeletePress, required this.todoCollections});
  
  final void Function(TodoCollection todoCollection) onLongPress;
  final void Function(TodoCollection todoCollection) onDeletePress;
  final List<TodoCollection> todoCollections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todoCollections.length,
      itemBuilder: buildTodoCollectionItem,
    );
  }

  void _goTo(BuildContext context, TodoCollection todoCollection) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => TodoScreen(),
        settings: RouteSettings(
          arguments: todoCollection
        )
      )
    );
  }

  Widget buildTodoCollectionItem(BuildContext context, int index) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      key: Key(todoCollections[index].id),
      title: Text(todoCollections[index].name),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        color: Colors.redAccent,
        onPressed: () => onDeletePress(todoCollections[index])
      ),
      onLongPress: () => onLongPress(todoCollections[index]),
      onTap: () => _goTo(context, todoCollections[index])
    );
  }

}