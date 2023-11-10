import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To-Do List', 
      home: TodoList()
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoListState createState() => _TodoListState();
}

class Todo {
  Todo({required this.name, required this.completed});
  String name;
  bool completed;
}


class _TodoListState extends State<TodoList> {
  List<Todo> todos = <Todo>[];
  static int s_NextId = 0;
  final TextEditingController textFieldController = TextEditingController();

  void _addTodo(String todo) async {
    Uri addTodoEndpointUri = Uri.https('api.todo-app.dev.victorkrogh.dk', 'api/v1/todo/$todo');
    print(addTodoEndpointUri.toString());

    var response = await http.post(
      addTodoEndpointUri,
      headers: <String, String>{
        'accept': 'application/json',
        'content-type': 'application/json',
        'X-Api-Key': 'Todo'
      }
    );

    print(response.statusCode);

    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    print(decodedResponse);

    setState(() {
      todos.add(Todo(name: todo, completed: false));
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      todos.remove(todo);
    });
  }

  void _updateTodo(Todo todo, bool? newState) {
    setState(() {
      todo.completed = newState ?? false;
    });
  }

  void _clearAllTodo() {
    setState(() {
      todos.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
          actions: [
            IconButton(
              onPressed: () => _clearAllTodo(),
              tooltip: 'Clear all Todos',
              icon: const Icon(Icons.clear)
            )
          ],
        ),
        body: ListView(
          children: todos.map((e) => 
            ListTile(
              title: Text(e.name),
              leading: Checkbox(
                onChanged: (newState) => _updateTodo(e, newState),
                value: e.completed
              ),
              trailing: IconButton(
                onPressed: () => _deleteTodo(e),
                icon: const Icon(Icons.delete)
              ),
            )
          ).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showMyDialog, // _addTodo("Todo #${++s_NextId}"),
          tooltip: 'Add a new Todo',
          child: const Icon(Icons.add)
        ),
      );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('AlertDialog Title'),
          content: CupertinoTextField(
            controller: textFieldController
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Don\'t Add'),
              onPressed: () {
                Navigator.pop(context);
              }
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Add'),
              onPressed: () {
                if(textFieldController.text.isEmpty) {
                  return;
                }

                _addTodo(textFieldController.text);
                textFieldController.text = '';

                Navigator.pop(context);
              }
            )
          ],
        );
      });
  }
}