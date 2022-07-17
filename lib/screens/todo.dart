import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks.dart';
import 'package:todo/sub_screens/newtask.dart';
import '../sub_screens/specifictask.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksData = Provider.of<TaskProvider>(context);
    final tasks = tasksData.tasks;
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
        body: tasks.isEmpty
            ? const Center(
                child: Text('You have no tasks'),
              )
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, i) => Consumer<TaskProvider>(
                  builder: ((context, value, child) => ListTile(
                        title: Text(tasks[i].title),
                        trailing: Text(tasks[i].duedate.toString()),
                        onTap: () {
                          final taskID = tasks[i].id;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SpecificTaskScreen(taskID),
                            ),
                          );
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       title: Text(tasks[i].title),
                          //       content: Text(tasks[i].description),
                          //       actions: <Widget>[
                          //         Button(
                          //           color: Colors.blue,
                          //           onPressed: () =>
                          //               Navigator.of(context).pop(),
                          //           title: 'Edit',
                          //         ),
                          //         Button(
                          //           color: Colors.red,
                          //           onPressed: () {
                          //             Provider.of<TaskProvider>(context,
                          //                     listen: false)
                          //                 .removeTask(
                          //               tasks[i],
                          //             );
                          //             Navigator.of(context).pop();
                          //           },
                          //           title: 'Delete',
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                        },
                      )),
                ),
              ),
      ),
    );
  }
}
