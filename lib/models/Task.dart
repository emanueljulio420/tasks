class Task {
  late String name;
  late String description;
  late bool? complete;
  late int priority;

  Task({required this.name, required this.description, required this.priority});

  Task.empty() {
    name = "";
    description = "";
    complete = false;
    priority = 0;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$name -> $description";
  }
}
