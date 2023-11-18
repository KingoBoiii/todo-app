import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo_collection_model.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoService {

  final String BaseUrl = 'api.todo-app.dev.victorkrogh.dk';
  final String ApiRoute = 'api/v1/todo';
  final String ApiKey = 'Todo';

  Future<List<Todo>> getTodosByTodoCollectionAsync(TodoCollection todoCollection) async {
    var response = await http.get(
      Uri.https(BaseUrl, 'api/v1/todo/collections/${todoCollection.id}/todos'),
      headers: <String, String>{
        'accept': 'application/json',
        'content-type': 'application/json',
        'X-Api-Key': ApiKey
      }
    );

    final parsed = (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    var list = parsed.map<Todo>((json) => Todo.fromJson(json)).toList();

    return list;
  }

  Future<List<Todo>> getTodosAsync() async {
    var response = await http.get(
      Uri.https(BaseUrl, ApiRoute),
      headers: <String, String>{
        'accept': 'application/json',
        'content-type': 'application/json',
        'X-Api-Key': ApiKey
      }
    );

    final parsed = (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    var list = parsed.map<Todo>((json) => Todo.fromJson(json)).toList();

    return list;
  }

  Future<Todo> addTodoAsync(String text) async {
    var response = await http.post(
      Uri.https(BaseUrl, "$ApiRoute/$text"),
      headers: <String, String>{
        'accept': 'application/json',
        'content-type': 'application/json',
        'X-Api-Key': ApiKey
      }
    );

    return Todo.fromJson(jsonDecode(response.body));
  }

  Future<bool> updateTodo(Todo todo) async {
    var response = await http.patch(
      Uri.https(BaseUrl, "$ApiRoute/${todo.id}"),
      headers: <String, String>{
        'accept': 'application/json',
        'content-type': 'application/json',
        'X-Api-Key': ApiKey
      },
      body: jsonEncode({
        "text": todo.text,
        "completed": todo.completed
      })
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteTodo(Todo todo) async {
    var response = await http.delete(
      Uri.https(BaseUrl, "$ApiRoute/${todo.id}"),
      headers: <String, String>{
        'accept': 'application/json',
        'content-type': 'application/json',
        'X-Api-Key': ApiKey
      }
    );

    return response.statusCode == 200;
  }

}