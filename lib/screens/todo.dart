import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks.dart';
import 'package:todo/screens/settings.dart';
import 'package:todo/sub_screens/newtask.dart';
import 'package:todo/widgets/button.dart';
import '../sub_screens/specifictask.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksData = Provider.of<TaskProvider>(context);
    final tasks = tasksData.tasks;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
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
                        subtitle: Text(tasks[i].duedate.toString()),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                content: const Text(
                                  'Are you sure you want to delete this task?',
                                ),
                                actions: [
                                  Button(
                                    onPressed: () {
                                      tasks[i].isComplete = true;
                                      Provider.of<TaskProvider>(context,
                                              listen: false)
                                          .removeTask(tasks[i]);
                                      Navigator.of(context).pop();
                                    },
                                    color: Colors.red,
                                    title: 'Delete',
                                  ),
                                  Button(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      color: Colors.green,
                                      title: 'Cancel')
                                ],
                              ),
                            );
                          },
                        ),
                        // onLongPress: () {
                        //   showBottomSheet(
                        //     context: context,
                        //     builder: (_) => Container(),
                        //   );
                        // },

                        onTap: () {
                          final taskID = tasks[i].id;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SpecificTaskScreen(taskID),
                            ),
                          );
                        },
                      )),
                ),
              ),
      ),
    );
  }
}
