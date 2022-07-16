import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        body: Form(
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
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: dateInput,
                    //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "Enter Date" //label text of field
                        ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    maxLength: 50,
                    cursorColor: Colors.grey,
                    controller: newDescriptionController,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) {
                      setState(() {});
                    },
                    validator: (value) {
                      if (value!.isNotEmpty) {
                      } else
                        return null;
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      () {}, // Add the task to the main todo screen and to the database
                  child: const Text('Save'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    newTitleController.dispose();
                    newDescriptionController.dispose();
                    dateInput.dispose();
                    Navigator.pop(context);
                  }, // Using Navigator, pop back into the main screen and do not save task information.
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
