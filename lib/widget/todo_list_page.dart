import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/widget/todo_list_add_dialog.dart';
import 'package:todo_app/widget/todo_list_update_dialog.dart';
import 'package:todo_app/widget/todo_list_widget.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<StatefulWidget> createState() => _TodoListPageState();

}

class _TodoListPageState extends State<TodoListPage> {

  final TodoService _todoService = TodoService();
  final TextEditingController textFieldController = TextEditingController();

  void _addTodo(String text) {
    _todoService.addTodoAsync(text);
    setState(() {});
  }

  void _updateTodo(Todo todo) {
    _todoService.updateTodo(todo); 
    setState(() {});
  }

  void _deleteTodo(Todo todo) {
    _todoService.deleteTodo(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: IconButton(
          onPressed: () { setState(() {}); },
          icon: const Icon(Icons.refresh)
        ),
      ),
      body: FutureBuilder(
        future: _todoService.getTodosAsync(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred')
            );
          }
          else if(snapshot.hasData) {
            return TodoList(
              todos: snapshot.data!, 
              onLongPress: _showTodoDialog,
              onCompletedChanged: _updateTodo, 
              onDelete: _deleteTodo
            );
          }
          else {
            return const Center(
              child: CircularProgressIndicator()
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTodoDialog(null),
        tooltip: 'Add a new Todo',
        child: const Icon(Icons.add)
      ),
    );
  }

  Future<void> _showTodoDialog(Todo? todo) async {
    textFieldController.text = todo?.text ?? '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return todo == null ? 
          TodoListAddDialog(
            onAdd: _addTodo
          ) : 
          TodoListUpdateDialog(
            todo: todo,
            onUpdate: _updateTodo
          );
      }
    );
  }

}