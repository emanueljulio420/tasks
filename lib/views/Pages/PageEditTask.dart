import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/controllers/TaskController.dart';
import 'package:task/controllers/TaskProvider.dart';
import 'package:task/models/Task.dart';

class PageEditTask extends StatelessWidget {
  // Atributos

  final TaskController _controller = TaskController();

  final GlobalKey<FormState> _key = GlobalKey();
  Task task = Task.empty();
  int index = 0;

  PageEditTask({required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit task"),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<TaskProvider>(
        builder: (_, taskProvider, child) {
          return taskForm(context, taskProvider);
        },
      ),
    );
  }

  Form taskForm(BuildContext context, TaskProvider provider) {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: task.name,
              onChanged: (value) => task.name = value,
              validator: validate,
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Enter the name",
              ),
            ),
            TextFormField(
              initialValue: task.description,
              onChanged: (value) => task.description = value,
              validator: validate,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Description",
                hintText: "Enter the description",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.update(task.tomap(), task.id);
                editTask(_key, task, provider, index);
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (_) => dialog("Task updated", Icons.check),
                );
              },
              child: const Text("Edit"),
            )
          ],
        ),
      ),
    );
  }
}
