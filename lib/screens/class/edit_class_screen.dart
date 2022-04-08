import 'package:flutter/material.dart';
import 'package:teach_rate/models/Class.dart';

class EditClassScreen extends StatefulWidget {
  final Class _class;
  const EditClassScreen(this._class);

  @override
  State<EditClassScreen> createState() => _EditClassScreenState();
}

class _EditClassScreenState extends State<EditClassScreen> {
  final _formKey = GlobalKey<FormState>();
  late FocusScopeNode node;
  TextEditingController teacher = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController fee = TextEditingController();
  TextEditingController day = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController grade = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Update Class'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {},
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
                teacherField(),
                timeField(),
                locationField(),
                feeField(),
                dayField(),
                subjectField(),
                gradeField(),
                descriptionField(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget teacherField() {
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
        controller: teacher,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Teacher",
          hintText: "Teacher",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget timeField() {
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
        controller: time,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Time",
          hintText: "Time",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget locationField() {
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
        controller: location,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Location",
          hintText: "Location",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget feeField() {
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
        controller: fee,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Fee",
          hintText: "Fee",
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

  Widget dayField() {
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
        controller: day,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Day",
          hintText: "Day",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget gradeField() {
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
        controller: grade,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Grade",
          hintText: "Grade",
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
}
