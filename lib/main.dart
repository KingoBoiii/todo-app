import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_provider.dart';
import 'package:todo_app/views/todo_collection/todo_collection_screen.dart';

void main() async {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      lazy: false,
      child: Consumer<AppProvider>(
        builder: (context, state, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: true,
            title: 'To-Do list',
            theme: ThemeData(
              useMaterial3: true
            ),
            home: Scaffold(
              appBar: AppBar(
                title: const Text('To-Do List')
              ),
              body: Center(
                child: IntrinsicWidth(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child:           ElevatedButton.icon(
                    onPressed: () {
                      final state = Provider.of<AppProvider>(context, listen: false);
                      state.signInGoogle();
                    },
                    icon: const Icon(Icons.g_mobiledata),
                    label: const Text("Sign in with Google"),
                  ),
                  ),
                ),
              )
            ) 
          );
        }
      ),
    );

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
  }
}
