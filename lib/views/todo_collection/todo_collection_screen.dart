import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_collection_model.dart';
import 'package:todo_app/services/todo_collection_service.dart';
import 'package:todo_app/views/add_alert_dialog.dart';
import 'package:todo_app/views/todo_collection/todo_collection_list_widget.dart';
import 'package:todo_app/views/update_alert_dialog.dart';

class TodoCollectionScreen extends StatefulWidget {
  const TodoCollectionScreen({super.key});

  @override
  State<TodoCollectionScreen> createState() => _TodoCollectionScreenState();
}

class _TodoCollectionScreenState extends State<TodoCollectionScreen> {
  final TodoCollectionService _todoCollectionService = TodoCollectionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Collections"),
      ),
      body: FutureBuilder(
        future: _todoCollectionService.getTodoCollectionsAsync(), 
        builder: buildTodoCollectionBody
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTodoCollectionDialog(null),
        tooltip: 'Add a new collection',
        child: const Icon(Icons.add)
      )
    );
  }

  Widget buildTodoCollectionBody(BuildContext context, AsyncSnapshot<List<TodoCollection>> snapshot) {
    if(snapshot.hasError) {
      return const Center(
        child: Text('An error has occurred')
      );
    }
    else if(snapshot.hasData) {
      return TodoCollectionList(
        todoCollections: snapshot.data!,
        onLongPress: (TodoCollection todoCollection) => _showTodoCollectionDialog(todoCollection)
      );
    }
    else {
      return const Center(
        child: CircularProgressIndicator()
      );
    }
  }

  void _pop() {
    Navigator.of(context).pop();
  }
  
  Future<void> _showTodoCollectionDialog(TodoCollection? todoCollection) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return todoCollection == null ? 
          AddAlertDialog(
            title: 'Add Todo Collection',
            onPreBuild: (textFieldController) {
              textFieldController.text = '';
            },
            onAddClicked: (TextEditingController textFieldController) {
              if(textFieldController.text.isEmpty) {
                return;
              }

              _todoCollectionService.addTodoCollectionAsync(textFieldController.text)
                .then((value) => setState(() {}));

              textFieldController.text = '';
              Navigator.of(context).pop();
            }, 
            onCancelClicked: _pop
          ) : 
          UpdateAlertDialog(
            title: 'Update Todo Collection',
            onPreBuild: (textEditingController) {
              textEditingController.text = todoCollection.name;
            },
            onUpdateClicked: (TextEditingController textFieldController) {
              if(textFieldController.text.isEmpty) {
                return;
              }

              todoCollection.name = textFieldController.text;
              _todoCollectionService.updateTodoCollectionAsync(todoCollection)
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

