import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          title: Text(
            FirebaseAuth.instance.currentUser!.emailVerified
                ? FirebaseAuth.instance.currentUser!.email.toString()
                : 'no user',
            // 'fix null check error',
          ),
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
                        title: Text(tasks[i].title.toString()),
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
                                      // Firestore Removing task (temporary solution for getting the id (set as the title) taken from provider -- change this later)
                                      removeTaskFromFirestore(
                                        tasks[i].title,
                                      );
                                      // Provider Removing task
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
                        onTap: () {
                          final taskID = tasks[i].id;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  SpecificTaskScreen(taskID.toString()),
                            ),
                          );
                        },
                      )),
                ),
              ),
      ),
    );
  }

  removeTaskFromFirestore(taskId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    await firebaseFirestore
        .collection('users')
        .doc(user?.uid)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }
}
