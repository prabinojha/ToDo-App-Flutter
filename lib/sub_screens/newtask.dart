import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks.dart';
import 'package:todo/widgets/button.dart';

import '../widgets/text_field.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TextEditingController newTitleController = TextEditingController();
  final TextEditingController newDescriptionController =
      TextEditingController();

  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add a new task'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              textField(
                newTitleController,
                TextInputType.text,
                50,
                1,
                'Title',
              ),
              textField(
                newDescriptionController,
                TextInputType.multiline,
                300,
                15,
                'Description',
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
                  controller: dateInput,
                  //editing controller of this TextField
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Due Date",
                  ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(
                        () {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        },
                      );
                    } else {
                      setState(
                        () {
                          dateInput.text = 'No Date';
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Button(
                onPressed: () {
                  if (newDescriptionController.text.isEmpty ||
                      newTitleController.text.isEmpty ||
                      dateInput.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (_) => const AlertDialog(
                        title: Text('At least provide some information!'),
                      ),
                    );
                  } else {
                    // Adding to the firestore database on a collection from an individual account (assuming that they are logged in and have email verified)
                    addTaskToFirestore();

                    // Adding to the provider (remove this later when server side code is ready)
                    Task newTask = Task(
                      description: newDescriptionController.text,
                      title: newTitleController.text,
                      duedate: dateInput.text,
                      id: DateTime.now().toString(),
                      isComplete: false,
                    );
                    Provider.of<TaskProvider>(context, listen: false)
                        .add(newTask);
                    newTitleController.clear();
                    newDescriptionController.clear();
                    dateInput.clear();
                    Navigator.pop(context);
                  }
                },
                color: const Color.fromRGBO(114, 76, 249, 1),
                title: 'Add Task',
              ),
              Button(
                color: const Color.fromRGBO(248, 70, 76, 1),
                onPressed: () {
                  newTitleController.clear();
                  newDescriptionController.clear();
                  dateInput.clear();
                  Navigator.pop(context);
                },
                title: 'Cancel',
              ),
            ],
          ),
        ),
      ),
    );
  }

  addTaskToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    User? user = FirebaseAuth.instance.currentUser;
    Task task = Task();

    task.description = newDescriptionController.value.text;
    task.title = newTitleController.value.text;
    task.duedate = dateInput.value.text;

    String title = newTitleController.value.text;

    await firebaseFirestore
        .collection('users')
        .doc(user?.uid)
        .collection('tasks')
        .doc(title) // change this to something dynamic because different tasks might have the same title
        .set(
          task.toMap(),
        );
  }
}
