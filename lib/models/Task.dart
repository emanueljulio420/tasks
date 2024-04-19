class Task {
  late String id;
  late String name;
  late String description;
  late bool? complete;
  late int priority;

  Task({required this.name, required this.description, required this.priority});

  Task.empty() {
    id = "";
    name = "";
    description = "";
    complete = false;
    priority = 0;
  }

  Map<String, dynamic> tomap() {
    Map<String, dynamic> taskMap = {
      'name': name,
      'description': description,
      'priority': priority,
      'complete': complete
    };
    return taskMap;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$id:$name -> $description";
  }
}
