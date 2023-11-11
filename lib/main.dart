import 'package:flutter/material.dart';
import 'package:todo_app/widget/todo_list_page.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List', 
      theme: ThemeData(
        useMaterial3: true
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
          actions: [
            IconButton(
              onPressed: () {}, 
              icon: const Icon(Icons.person)
            )
          ],
        ),
        drawer: const NavigationDrawer(
          children: [
            DrawerHeader(
              child: Center(
                child: Text('Hello world!')
              )
            )
          ],
        ),
        body: const TodoListPage()
      )
    );
  }
}
