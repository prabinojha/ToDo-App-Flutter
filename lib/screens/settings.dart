import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Button(
            color: Colors.black,
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            title: 'Sign Out',
          ),
        ),
      ),
    );
  }
}
