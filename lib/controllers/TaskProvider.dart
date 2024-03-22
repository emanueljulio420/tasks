import 'package:flutter/material.dart';
import 'package:task/models/Task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  editTask(Task task, int index) {
    _tasks[index] = task;
    notifyListeners();
  }
}
