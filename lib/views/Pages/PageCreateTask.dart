import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/controllers/TaskController.dart';
import 'package:task/controllers/TaskProvider.dart';
import 'package:task/models/Task.dart';

class PagecreateTask extends StatefulWidget {
  @override
  State<PagecreateTask> createState() => _PagecreateTaskState();
}

class _PagecreateTaskState extends State<PagecreateTask> {
  // Atributos
  final GlobalKey<FormState> _key = GlobalKey();

  final TaskController _controller = TaskController();

  Task task = Task.empty();

  dynamic priority = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create task"),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<TaskProvider>(
        builder: (_, taskProvider, child) {
          return taskForm(taskProvider);
        },
      ),
    );
  }

  Form taskForm(TaskProvider provider) {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) => task.name = value,
              validator: validate,
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Enter the name",
              ),
            ),
            TextFormField(
              onChanged: (value) => task.description = value,
              validator: validate,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Description",
                hintText: "Enter the description",
              ),
            ),
            const Text("Priority"),
            RadioListTile(
                title: const Text("1"),
                value: 1,
                groupValue: priority,
                onChanged: (value) {
                  priority = value;
                  setState(() {});
                }),
            RadioListTile(
                title: const Text("2"),
                value: 2,
                groupValue: priority,
                onChanged: (value) {
                  priority = value;
                  setState(() {});
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    task.priority = priority;
                    _controller
                        .create(task.tomap())
                        .then((id) => task.id = id)
                        .catchError((error) => print(error));
                    saveTask(_key, task, provider);
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (_) => dialog("Task created", Icons.check),
                    );
                  },
                  child: const Text("Save"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
