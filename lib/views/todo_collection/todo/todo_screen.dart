import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_collection_model.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/views/add_alert_dialog.dart';
import 'package:todo_app/views/todo_collection/todo/todo_list_widget.dart';
import 'package:todo_app/views/update_alert_dialog.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoService _todoService = TodoService();

  TodoCollection? _todoCollection;

  @override
  Widget build(BuildContext context) {
    _todoCollection = ModalRoute.of(context)!.settings.arguments as TodoCollection;
    if(_todoCollection == null) {
      FlutterError("Todo Collection is not defined!");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_todoCollection!.name),
      ),
      body: FutureBuilder(
        future: _todoService.getTodosByTodoCollectionAsync(_todoCollection!), 
        builder: buildTodoListView
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTodoDialog(null),
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
      return TodoList(
        todos: snapshot.data!,
        onLongPress: (Todo todo) => _showTodoDialog(todo), 
        onCheckboxChanged: (todo) {
          _todoService.updateTodoAsync(_todoCollection!, todo)
            .then((value) => setState(() {}));
        },
        onDeletePress: (todo) {
          _todoService.deleteTodoAsync(_todoCollection!, todo)
            .then((value) => setState(() {}));
        }
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
  
  void _pop() {
    Navigator.of(context).pop();
  }
  
  Future<void> _showTodoDialog(Todo? todo) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return todo == null ? 
          AddAlertDialog(
            title: 'Add Todo',
            onPreBuild: (textFieldController) {
              textFieldController.text = '';
            },
            onAddClicked: (TextEditingController textFieldController) {
              if(textFieldController.text.isEmpty) {
                return;
              }

              _todoService.addTodoAsync(_todoCollection!, textFieldController.text)
                .then((value) => setState(() {}));

              textFieldController.text = '';
              Navigator.of(context).pop();
            }, 
            onCancelClicked: _pop
          ) : 
          UpdateAlertDialog(
            title: 'Update Todo',
            onPreBuild: (textEditingController) {
              textEditingController.text = todo.text;
            },
            onUpdateClicked: (TextEditingController textFieldController) {
              if(textFieldController.text.isEmpty) {
                return;
              }

              todo.text = textFieldController.text;
              _todoService.updateTodoAsync(_todoCollection!, todo)
                .then((value) => setState(() {}));

              textFieldController.text = '';
              Navigator.of(context).pop();
            }, 
            onCancelClicked: _pop
          );
      }
    );
  }

}

