import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/controllers/TaskController.dart';
import 'package:task/controllers/TaskProvider.dart';
import 'package:task/models/Task.dart';
import 'package:task/views/Pages/PageCreateTask.dart';
import 'package:task/views/Pages/PageEditTask.dart';

class PageListTasks extends StatefulWidget {
  const PageListTasks({super.key});

  @override
  State<PageListTasks> createState() => _PageListTasksState();
}

class _PageListTasksState extends State<PageListTasks> {
  late TaskProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Tasks"),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<TaskProvider>(
        builder: (_, taskprovider, child) {
          provider = taskprovider;
          return getList(taskprovider);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PagecreateTask(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
    // floatingActionButton: FloatingActionButton
  }

  Widget getList(TaskProvider provider) {
    List<Task> tasks = provider.tasks;
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (_, index) {
              Task task = tasks[index];
              return tasktitle(task, provider, index);
            }));
  }

  Widget tasktitle(Task task, TaskProvider provider, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
          color: task.priority == 1
              ? const Color.fromARGB(255, 253, 110, 100)
              : const Color.fromARGB(255, 255, 244, 142),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Checkbox(
              value: task.complete,
              onChanged: (value) {
                task.complete = value;
                setState(() {});
              },
            ),
            Column(
              children: [
                Text(
                  task.name,
                  style: task.complete == false
                      ? const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w800)
                      : const TextStyle(color: Colors.grey),
                ),
                Text(
                  task.description,
                  style: task.complete == false
                      ? const TextStyle(fontWeight: FontWeight.w200)
                      : const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Text(
              "${task.priority}",
              style: task.complete == false
                  ? const TextStyle(fontWeight: FontWeight.w800)
                  : const TextStyle(color: Colors.grey),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PageEditTask(
                      task: task,
                      index: index,
                    ),
                  ));
                },
                icon: const Icon(
                  Icons.edit,
                )),
            IconButton(
              onPressed: () {
                deleteTask(task, provider);
                showDialog(
                  context: context,
                  builder: (_) => dialog("Task deleted", Icons.check),
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
