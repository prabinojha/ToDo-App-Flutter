import 'package:todo/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 35,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                height: 150,
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2019/08/30/15/48/lock-4441691_960_720.png',
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                child: Text(
                  'Enter Your Email',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 25,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
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
                    hintText: 'Email',
                    fillColor: Colors.grey,
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(2, 43, 58, 0.4),
                    ),
                  ),
                ),
              ),
              Button(
                color: Theme.of(context).primaryColor,
                title: 'Send Request',
                onPressed: () async {
                  await auth
                      .sendPasswordResetEmail(
                        email: emailController.text,
                      )
                      .then(
                        (value) => showDialog(
                          context: context,
                          builder: (ctx) => Dialog(
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              child: Text(
                                'Check your email: ${emailController.text}',
                              ),
                            ),
                          ),
                        ),
                      )
                      .catchError(
                    (error) {
                      String errorMessage = error.message;
                      print(errorMessage);
                    },
                  );
                },
                // send email to user for further instructions to reset password
              ),
            ],
          ),
        ),
      ),
    );
  }
}
