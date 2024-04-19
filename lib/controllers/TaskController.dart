import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/controllers/TaskProvider.dart';
import 'package:task/models/Task.dart';

class TaskController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  final String collection = "task";

  Future<String> create(Map<String, dynamic> task) async {
    DocumentReference response = await db.collection(collection).add(task);
    return response.id;
  }

  Future<void> update(Map<String, dynamic> task, String id) async {
    await db.collection(collection).doc(id).update(task);
  }

  Future<void> delete(String id) async {
    await db.collection(collection).doc(id).delete();
  }

  getTask() async {
    QuerySnapshot snapshot = await db.collection(collection).get();
    return snapshot.docs;
  }
}

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
