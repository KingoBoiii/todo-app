class Todo {

  String id;
  String text;
  bool completed;

  Todo({required this.id, required this.text, required this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      text: json['text'],
      completed: json['completed']
    );
  }
      
}