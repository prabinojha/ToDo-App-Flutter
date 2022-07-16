import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks.dart';
import 'package:todo/sub_screens/newtask.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              // pushes to a new page where you can add a task
              MaterialPageRoute(builder: (context) => const NewTaskScreen()),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<TaskProvider>(
          builder: (context, task, child) {
            return Text(task.totalTasks.toString());
          },
        ),
      ),
    );
  }
}
