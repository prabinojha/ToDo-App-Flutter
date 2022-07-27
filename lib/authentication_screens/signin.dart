import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/authentication_screens/resetPassword.dart';
import 'package:todo/screens/todo.dart';

import '../widgets/button.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/sign-in';

  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // form key
  final _formKey = GlobalKey<FormState>();
  // //editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        highlightElevation: 0,
        onPressed: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  color: Color.fromRGBO(2, 43, 58, 1),
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.grey,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email.";
                          }
                          //reg expresssion for email validation

                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[a-z]")
                              .hasMatch(value)) {
                            return "Please enter a valid email.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
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
                          hintText: 'Email',
                          fillColor: Colors.grey,
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(2, 43, 58, 0.4),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        cursorColor: Colors.grey,
                        controller: passwordController,
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return "Please enter a password.";
                          }
                          if (!regex.hasMatch(value)) {
                            return "Please enter a valid password (Minium 6 characters)";
                          }
                        },
                        decoration: InputDecoration(
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
                          hintText: 'Password',
                          fillColor: Colors.grey,
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(2, 43, 58, 0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const ResetPasswordScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color.fromRGBO(
                        2,
                        43,
                        58,
                        0.6,
                      ),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Button(
                color: Theme.of(context).primaryColor,
                title: 'Sign In',
                onPressed: () {
                  signIn(
                    emailController.text,
                    passwordController.text,
                  );
                },
              ),
              Button(
                color: Theme.of(context).accentColor,
                title: 'Sign Up',
                onPressed: () {
                  MaterialPageRoute(builder: (context) => const ToDoScreen());
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then(
            (uid) => {
              print('successful'),
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => ToDoScreen(),
                ),
              ),
            },
          )
          .catchError(
        (error) {
          print(error);
        },
      );
    }
  }
}
