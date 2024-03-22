import 'package:flutter/material.dart';
import 'package:task/controllers/TaskProvider.dart';
import 'package:task/models/Task.dart';

String? validate(value) {
  return value == null || value!.isEmpty ? "Este campo es obligatorio" : null;
}

saveTask(GlobalKey<FormState> _key, Task task, TaskProvider provider) {
  if (_key.currentState!.validate() && task.priority != 0) {
    provider.addTask(task);
  }
}

deleteTask(Task task, TaskProvider provider) {
  provider.deleteTask(task);
}

editTask(
    GlobalKey<FormState> _key, Task task, TaskProvider provider, int index) {
  if (_key.currentState!.validate()) {
    provider.editTask(task, index);
  }
}

Widget dialog(String title, IconData icon) {
  return AlertDialog(
    title: Text(title),
    content: Icon(icon),
    elevation: 10,
  );
}
