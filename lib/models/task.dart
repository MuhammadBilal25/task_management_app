class Task {
  String title;
  String description;
  bool isDone;

  Task({required this.title, required this.description, this.isDone = false});

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'isDone': isDone,
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json['title'],
    description: json['description'],
    isDone: json['isDone'],
  );
}
