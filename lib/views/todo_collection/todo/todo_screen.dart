import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_collection_model.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/views/todo_collection/todo_collection_list_widget.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({super.key});
  
  final TodoService _todoService = TodoService();

  @override
  Widget build(BuildContext context) {
    final todoCollection = ModalRoute.of(context)!.settings.arguments as TodoCollection;

    return Scaffold(
      appBar: AppBar(
        title: Text(todoCollection.name),
      ),
      body: FutureBuilder(
        future: _todoService.getTodosByTodoCollectionAsync(todoCollection), 
        builder: buildTodoListView
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add a new Todo',
        child: const Icon(Icons.add)
      )
    );
  }

  Widget buildTodoListView(BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
    if(snapshot.hasError) {
      return const Center(
        child: Text('An error has occurred')
      );
    }
    else if(snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) => buildTodoItem(snapshot.data![index]),
      );
    }
    else {
      return const Center(
        child: CircularProgressIndicator()
      );
    }
  }

  Widget buildTodoItem(Todo todo) {
    return ListTile(
      key: Key(todo.id),
      title: Text(todo.text),
      trailing: const IconButton(
        icon: Icon(Icons.arrow_right_alt),
        onPressed: null
      ),
      onTap: () {
        print('Tapped');
      },
    );
  }

}

