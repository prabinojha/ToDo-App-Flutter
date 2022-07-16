import 'package:flutter/material.dart';
import 'package:todo/sub_screens/newtask.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push( // pushes to a new page where you can add a task
              MaterialPageRoute(builder: (context) => const NewTaskScreen()),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Column( // This is where the new tasks should be dosplayed
          children: [

          ],
        ),
      ),
    );
  }
}
