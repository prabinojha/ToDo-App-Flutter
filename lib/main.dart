import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/authentication_screens/signin.dart';
import 'package:todo/authentication_screens/signup.dart';
import 'package:todo/authentication_screens/verify_email.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/providers/notes.dart';
import 'package:todo/providers/tasks.dart';
import 'package:todo/screens/todo.dart';

import 'screens/notes.dart';
import 'widgets/menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
        Provider(
          create: (context) => NotesProvider(),
        ),
      ],
      child: const ToDoApp(),
    ),
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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
              return Builder(
                builder: (context) => DefaultTabController(
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
            } else {
              return Builder(
                builder: (context) {
                  return VerifyEmailPage();
                },
              );
            }
          } else {
            return const SignIn();
          }
        },
      ),
    );
  }
}
