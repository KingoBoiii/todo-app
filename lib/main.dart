import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class ToDo {
  String todo;
  bool completed = false;
  
  ToDo(this.todo);
}

class ToDoList {
  String name;
  IconData icon;
  List<ToDo> todos;
  
  ToDoList(this.name, this.icon, this.todos);
}

final List<ToDoList> todoLists = <ToDoList>[
  ToDoList(
    'Shopping',
    Icons.shopping_bag,
    <ToDo>[
      ToDo('Rugbrød'),
      ToDo('Småkage')
    ] 
  ),
  ToDoList(
    'Gaming',
    Icons.gamepad,
    <ToDo>[
      ToDo('Arma 3')
    ] 
  )
];

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoTabLayout()
    );
  }
}

class TodoTabLayout extends StatelessWidget {
  const TodoTabLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Tuple2<Tab, Widget>> tabs = todoLists
      .expand((element) => element.todos.map((e) => Tuple2(
          Tab(
            icon: Icon(element.icon),
            child: Text(element.name)
          ),
          Center(
            child: Text("${e.todo}: ${e.completed}")
          )
        )))
      .toList();

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Tabs Demo'),
          bottom: TabBar(
            isScrollable: true,
            tabs: tabs.map((e) => e.item1).toList()
          ),
        ),
        drawer: const Drawer(
          child: SafeArea( 
            child: Text('Hello World!') 
          ),
        ),
        body: TabBarView(
          children: tabs.map((e) => e.item2).toList(),
        ),
      ),
    );
  }
}
