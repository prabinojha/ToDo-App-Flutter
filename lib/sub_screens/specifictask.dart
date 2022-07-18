import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks.dart';

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

    newTitleController.text = specificTask.title;
    newDescriptionController.text = specificTask.description;
    dateInput.value = TextEditingValue(text: specificTask.duedate);

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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      maxLength: 50,
                      cursorColor: Colors.grey,
                      controller: newTitleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: specificTask.title,
                        contentPadding: const EdgeInsets.all(15),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(2, 43, 58, 0.5),
                            width: 2.0,
                          ),
                        ),
                        fillColor: Colors.grey,
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(2, 43, 58, 0.4),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      maxLength: 300,
                      maxLines: 15,
                      cursorColor: Colors.grey,
                      controller: newDescriptionController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: specificTask.description,
                        contentPadding: const EdgeInsets.all(15),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(2, 43, 58, 0.5),
                            width: 2.0,
                          ),
                        ),
                        fillColor: Colors.grey,
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(2, 43, 58, 0.4),
                        ),
                      ),
                    ),
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
                      onPressed: () {
                        Provider.of<TaskProvider>(context, listen: false)
                            .updateTask(
                          specificTask.id,
                          newTitleController.text,
                          newDescriptionController.text,
                          dateInput.text,
                        );
                        Navigator.of(context).pop();
                      },
                      color: const Color.fromRGBO(114, 76, 249, 1),
                      title: 'Save'),
                  Button(
                    color: const Color.fromRGBO(248, 70, 76, 1),
                    onPressed: () {
                      Provider.of<TaskProvider>(context, listen: false)
                          .removeTask(specificTask);
                      newTitleController.clear();
                      newDescriptionController.clear();
                      dateInput.clear();
                      Navigator.pop(context);
                    },
                    title: 'Delete',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
