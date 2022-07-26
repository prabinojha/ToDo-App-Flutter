import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/widgets/button.dart';

import '../screens/todo.dart';

class VerifyEmailPage extends StatefulWidget {
  VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendEmailVerification();
      Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
    ;
  }

  Future sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(
        const Duration(seconds: 5),
      );
      setState(() => canResendEmail = true);
    } catch (error) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text(
            error.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color.fromRGBO(114, 76, 249, 1),
            accentColor: const Color.fromRGBO(212, 175, 55, 1),
          ),
          home: ToDoScreen(),
        )
      : Scaffold(
          appBar: AppBar(
            title: const Text('Verify Email'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'A verification email has been sent to your email',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Button(
                  onPressed: canResendEmail ? sendEmailVerification : () {},
                  color: Colors.blue,
                  title: 'Resend Email',
                ),
                Button(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  color: Colors.red,
                  title: 'Cancel',
                ),
              ],
            ),
          ),
        );
}
