class TodoCollection {

  String id;
  String name;

  TodoCollection({required this.id, required this.name});

  factory TodoCollection.fromJson(Map<String, dynamic> json) {
    return TodoCollection(
      id: json['id'],
      name: json['name']
    );
  }

}

