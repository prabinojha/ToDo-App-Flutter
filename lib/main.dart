import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/notes.dart';
import 'package:todo/providers/tasks.dart';
import './screens/settings.dart';
import './screens/notes.dart';
import './screens/todo.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => TaskProvider()),
      Provider(create: (context) => NotesProvider()),
    ], child: const ToDoApp()),
  );
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(114, 76, 249, 1),
        accentColor: const Color.fromRGBO(212, 175, 55, 1),
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: const TabBarView(
            children: [
              ToDoScreen(),
              NotesScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: const Color.fromRGBO(63, 90, 166, 1),
      child: const TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Color.fromRGBO(255, 255, 255, 1),
        tabs: [
          Tab(
            icon: Icon(Icons.assignment),
          ),
          Tab(
            icon: Icon(Icons.notes),
          ),
        ],
      ),
    );
  }
}
