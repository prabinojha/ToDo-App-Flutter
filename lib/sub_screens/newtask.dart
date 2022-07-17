import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks.dart';
import 'package:todo/widgets/button.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _formKey = GlobalKey<FormState>();
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
                      onSaved: (value) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          value = 'Unamed Task';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Title',
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
                      onSaved: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Description',
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
                          setState(() {
                            dateInput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          setState(() {
                            dateInput.text = 'No Date';
                          });
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
                          Task newTask = Task(
                            description: newDescriptionController.text,
                            title: newTitleController.text,
                            duedate: dateInput.text,
                            id: DateTime.now().toString(),
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
}
