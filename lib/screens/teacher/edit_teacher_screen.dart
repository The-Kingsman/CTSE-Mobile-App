import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:teach_rate/models/Teacher.dart';
import 'package:teach_rate/providers/TeacherProvider.dart';
import 'package:teach_rate/screens/teacher/teachers_screen.dart';

class EditTeacherScreen extends StatefulWidget {
  final Teacher _teacher;
  const EditTeacherScreen(this._teacher);

  @override
  State<EditTeacherScreen> createState() => _EditTeacherScreenState();
}

class _EditTeacherScreenState extends State<EditTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  late FocusScopeNode node;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    name.text = widget._teacher.name;
    email.text = widget._teacher.email;
    age.text = widget._teacher.age;
    contact.text = widget._teacher.contact;
    subject.text = widget._teacher.fieldofstudy;
    experience.text = widget._teacher.experience;
    qualification.text = widget._teacher.eduQualification;
    description.text = widget._teacher.about;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Update Teacher'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                updateTeacher();
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
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                nameField(),
                emailField(),
                ageField(),
                contactField(),
                subjectField(),
                experienceField(),
                qualificationField(),
                descriptionField(),
                const SizedBox(height: 20),
              ],
            ),
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

  Widget subjectField() {
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
        controller: subject,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Subject",
          hintText: "Subject",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget experienceField() {
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
        controller: experience,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Experience",
          hintText: "Experience",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget qualificationField() {
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
        controller: qualification,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Qualification",
          hintText: "Qualification",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget descriptionField() {
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
        controller: description,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Description",
          hintText: "Description",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  updateTeacher() async {
    FocusScope.of(context).unfocus();
    _formKey.currentState?.save();
    try {
      await Provider.of<TeacherProvider>(context, listen: false)
          .updateTeacher(
        widget._teacher.id,
        name.text,
        email.text,
        age.text,
        contact.text,
        experience.text,
        subject.text,
        qualification.text,
        description.text,
      )
          .then(
        (result) {
          if (result['result'] is String) {
            Fluttertoast.showToast(
              msg: result,
              backgroundColor: Colors.red.shade500,
              toastLength: Toast.LENGTH_SHORT,
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TeachersScreen(),
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
