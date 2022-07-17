import 'package:flutter/material.dart';
import 'dart:collection';

class Task {
  String title;
  String description;
  String duedate;
  String id;
  bool? isComplete;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.duedate,
    this.isComplete,
  });

  // USE THIS STRUCTURE LATER FOR SENDING DATA TO THE SERVER
  // // receiving data from the server and mapping into into our own fields
  // factory UserModel.fromMap(map) {
  //   return UserModel(
  //     uid: map['uid'],
  //     email: map['email'],
  //     name: map['name'],
  //     isPremium: map['false'],
  //   );
  // }

  // // sending data to our server
  // Map<String, dynamic> toMap() {
  //   return {
  //     'uid': uid,
  //     'email': email,
  //     'name': name,
  //     'isPremium': isPremium,
  //   };
  // }
}

class TaskProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Task> _tasks = [];

  List<Task> get tasks {
    return [..._tasks];
  }

  Task findById(String id) {
    return _tasks.firstWhere((task) => task.id == id);
  }

  void add(Task newtask) {
    _tasks.add(newtask);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void updateTask(taskId, newTitle, newDescription, newDueDate) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    _tasks[taskIndex].title = newTitle;
    _tasks[taskIndex].description = newDescription;
    _tasks[taskIndex].duedate = newDueDate;
    notifyListeners();
  }
}
