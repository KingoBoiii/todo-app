import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo_collection_model.dart';

class TodoCollectionService {

  final String BaseUrl = 'api.todo-app.dev.victorkrogh.dk';
  final String ApiRoute = 'api/v1/todo/collections';
  final String ApiKey = 'Todo';

  Future<List<TodoCollection>> getTodoCollectionsAsync() async {
    var response = await http.get(
      Uri.https(BaseUrl, ApiRoute),
      headers: <String, String>{
        'accept': 'application/json',
        'content-type': 'application/json',
        'X-Api-Key': ApiKey
      }
    );

    final parsed = (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    var list = parsed.map<TodoCollection>((json) => TodoCollection.fromJson(json)).toList();

    return list;
  }

  Future<TodoCollection> addTodoCollectionAsync(String name) async {
    var response = await http.post(
      Uri.https(BaseUrl, "$ApiRoute/$name"),
      headers: <String, String>{
        'accept': 'application/json',
        'content-type': 'application/json',
        'X-Api-Key': ApiKey
      }
    );

    return TodoCollection.fromJson(jsonDecode(response.body));
  }
  
  Future<TodoCollection> updateTodoCollectionAsync(TodoCollection todoCollection) async {
    var response = await http.patch(
      Uri.https(BaseUrl, "$ApiRoute/${todoCollection.id}"),
      headers: <String, String>{
        'accept': 'application/json',
        'content-type': 'application/json',
        'X-Api-Key': ApiKey
      },
      body: jsonEncode({
        "name": todoCollection.name
      })
    );

    return TodoCollection.fromJson(jsonDecode(response.body));
  }

  Future<bool> deleteTodoCollectionAsync(TodoCollection todoCollection) async {
    var response = await http.delete(
      Uri.https(BaseUrl, "$ApiRoute/${todoCollection.id}"),
      headers: <String, String>{
        'accept': 'application/json',
        'content-type': 'application/json',
        'X-Api-Key': ApiKey
      }
    );

    return response.statusCode == 200;
  }

}