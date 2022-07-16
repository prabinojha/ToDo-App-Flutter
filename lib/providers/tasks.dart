import 'package:flutter/material.dart';
import 'dart:collection';

class Task {
  String? title;
  String? description;
  String? duedate;
  bool? isComplete;

  Task({
    required this.title,
    required this.description,
    required this.duedate,
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

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  int get totalTasks => tasks.length;

  /// Adds [task] to list of tasks. This and [removeAll] are the only ways to modify the
  /// _tasks list from the outside.
  void add(Task newtask) {
    _tasks.add(newtask);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
