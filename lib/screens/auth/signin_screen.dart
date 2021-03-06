import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teach_rate/models/User.dart';
import 'package:teach_rate/providers/UserProvider.dart';
import 'package:teach_rate/screens/auth/signup_screen.dart';
import 'package:teach_rate/screens/teacher/teachers_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late FocusScopeNode node;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showPassword = false;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.teal.shade300,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    emailField(),
                    const SizedBox(height: 15),
                    passwordField(),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.teal,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Center(
                        child: Text(
                          "Don't have an account?",
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please fill this filed to continue';
          }
          return null;
        },
        controller: email,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Email",
          hintText: "Email",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        obscureText: !showPassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please fill this filed to continue';
          }
          return null;
        },
        controller: password,
        textInputAction: TextInputAction.done,
        onEditingComplete: () => node.unfocus(),
        decoration: InputDecoration(
          suffix: GestureDetector(
            onTap: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            child: showPassword
                ? const Icon(
                    Icons.visibility,
                    color: Colors.grey,
                    size: 20,
                  )
                : const Icon(
                    Icons.visibility_off,
                    color: Colors.grey,
                    size: 20,
                  ),
          ),
          labelText: "Password",
          hintText: "Password",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  signIn() async {
    FocusScope.of(context).unfocus();
    _formKey.currentState?.save();
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .signIn(
        email.text,
        password.text,
      )
          .then(
        (result) async {
          if (result['result'] is String) {
            Fluttertoast.showToast(
              msg: result['result'],
              backgroundColor: Colors.red.shade500,
              toastLength: Toast.LENGTH_SHORT,
            );
          } else {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('userID', result['result']['_id']);
            prefs.setString('name', result['result']['name']);
            prefs.setString('email', result['result']['email']);
            prefs.setString('age', result['result']['age']);
            prefs.setString('contact', result['result']['contact']);
            prefs.setString('password', result['result']['password']);
            prefs.setString('role', result['result']['role']);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const TeachersScreen(),
              ),
              (route) => false,
            );
          }
        },
        onError: (message) {
          Fluttertoast.showToast(
            msg: message.toString(),
            backgroundColor: Colors.red.shade500,
            toastLength: Toast.LENGTH_SHORT,
          );
        },
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red.shade500,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
