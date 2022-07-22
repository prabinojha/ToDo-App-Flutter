import 'package:flutter/material.dart';

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
