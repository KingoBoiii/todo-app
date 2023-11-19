import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_provider.dart';
import 'package:todo_app/views/main_layout.dart';
import 'package:todo_app/views/todo_collection/todo_collection_screen.dart';
import 'package:todo_app/views/unauth_layout.dart';

void main() async {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  static final ThemeData theme = ThemeData(
    useMaterial3: true
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      lazy: false,
      child: Consumer<AppProvider>(
        builder: (context, state, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: true,
            title: 'To-Do list awd',
            theme: theme,
            home: state.authenticated == false 
              ? const UnauthLayout()
              : const MainLayout(
                body: TodoCollectionScreen()
              )
          );
        }
      ),
    );
/*
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
        body: const TodoCollectionScreen() // const TodoListPage()
      )
    );
*/
  }
}
