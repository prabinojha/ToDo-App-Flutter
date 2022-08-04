import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks.dart';

import '../widgets/text_field.dart';

// ignore: must_be_immutable
class SpecificTaskScreen extends StatefulWidget {
  String taskID;
  SpecificTaskScreen(this.taskID, {Key? key}) : super(key: key);

  @override
  State<SpecificTaskScreen> createState() => _SpecificTaskScreenState();
}

class _SpecificTaskScreenState extends State<SpecificTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController newTitleController = TextEditingController();
  TextEditingController newDescriptionController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  late final id;

  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    id = widget.taskID;
    dateInput.text = "";
    newTitleController.text = "";
    newDescriptionController.text = "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TaskProvider taskInfo;
    final Task specificTask;
    taskInfo = Provider.of<TaskProvider>(context, listen: false);
    specificTask = taskInfo.findById(id);

    newTitleController.text = specificTask.title.toString();
    newDescriptionController.text = specificTask.description.toString();
    dateInput.value = TextEditingValue(text: specificTask.duedate.toString());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Task'),
        ),
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  textField(
                    newTitleController,
                    TextInputType.text,
                    50,
                    1,
                    specificTask.title,
                  ),
                  textField(
                    newDescriptionController,
                    TextInputType.multiline,
                    300,
                    15,
                    specificTask.description,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: TextField(
                      controller: dateInput,
                      //editing controller of this TextField
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: 'Due Date'),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);

                          dateInput.text = formattedDate;
                        } else {
                          dateInput.text = 'No Date';
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Button(
                      onPressed: () async {
                        // Provider editing/updating the task
                        Provider.of<TaskProvider>(context, listen: false)
                            .updateTask(
                          specificTask.id,
                          newTitleController.text,
                          newDescriptionController.text,
                          dateInput.text,
                        );
                        // Firebase editing/updating the task
                        await editTaskOnFirebase();

                        Navigator.of(context).pop();
                      },
                      color: const Color.fromRGBO(114, 76, 249, 1),
                      title: 'Save'),
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
        ),
      ),
    );
  }

  editTaskOnFirebase() async {
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
        .doc(
          title,
        ) // change this to something dynamic because different tasks might have the same title
        .update(
          task.toMap(),
        );
  }
}
