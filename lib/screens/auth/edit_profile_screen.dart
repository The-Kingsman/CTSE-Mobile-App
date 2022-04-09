import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teach_rate/models/User.dart';
import 'package:teach_rate/providers/UserProvider.dart';
import 'package:teach_rate/screens/auth/user_profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final String id, name, email, age, contact, password, role;
  const EditProfileScreen(this.id, this.name, this.email, this.age,
      this.contact, this.password, this.role);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late FocusScopeNode node;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool showPassword = false;
  @override
  void initState() {
    name.text = widget.name;
    email.text = widget.email;
    age.text = widget.age;
    contact.text = widget.contact;
    password.text = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Update Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                updateProfile();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    nameField(),
                    emailField(),
                    ageField(),
                    contactField(),
                    passwordField(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget nameField() {
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
        controller: name,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Name",
          hintText: "Name",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget ageField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please fill this filed to continue';
          }
          return null;
        },
        controller: age,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Age",
          hintText: "Age",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget contactField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please fill this filed to continue';
          }
          return null;
        },
        controller: contact,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Contact",
          hintText: "Contact",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
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
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                    size: 16,
                  )
                : const Icon(
                    Icons.visibility_off,
                    color: Colors.grey,
                    size: 16,
                  ),
          ),
          labelText: "Password",
          hintText: "Password",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  updateProfile() async {
    FocusScope.of(context).unfocus();
    _formKey.currentState?.save();
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .updateProfile(
        widget.id,
        name.text,
        email.text,
        age.text,
        contact.text,
        password.text,
        widget.role,
      )
          .then(
        (result) async {
          if (result['result'] is String) {
            Fluttertoast.showToast(
              msg: result,
              backgroundColor: Colors.red.shade500,
              toastLength: Toast.LENGTH_SHORT,
            );
          } else {
            final prefs = await SharedPreferences.getInstance();
            prefs.clear();

            prefs.setString('userID', result['result']['_id']);
            prefs.setString('name', result['result']['name']);
            prefs.setString('email', result['result']['email']);
            prefs.setString('age', result['result']['age']);
            prefs.setString('contact', result['result']['contact']);
            prefs.setString('password', result['result']['password']);
            prefs.setString('role', result['result']['role']);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewUserProfileScreen(
                    widget.id,
                    name.toString(),
                    email.toString(),
                    age.toString(),
                    contact.toString(),
                    password.toString(),
                    widget.role),
              ),
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
