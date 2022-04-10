import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teach_rate/Providers/RateProvider.dart';
import 'package:teach_rate/screens/teacher/teachers_screen.dart';

class addRate extends StatefulWidget {
  final String teacherId;
  const addRate(this.teacherId);

  @override
  State<addRate> createState() => _addRateState();
}

class _addRateState extends State<addRate> {
  final _formKey = GlobalKey<FormState>();
  late FocusScopeNode node;
  double value = 3.5;
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Rate'),
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
                commentField(),
                const SizedBox(height: 20),
                starRate(),
                Submit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commentField() {
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
        controller: comment,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => node.nextFocus(),
        decoration: const InputDecoration(
          labelText: "Comment",
          hintText: "Comment",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget Submit() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: () {
          createRate();
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
                'Submit',
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
    );
  }

  Widget starRate() {
    return Center(
      child: RatingStars(
        value: value,
        onValueChanged: (v) {
          setState(() {
            value = v;
          });
        },
        starBuilder: (index, color) => Icon(
          Icons.star,
          color: color,
        ),
        starCount: 5,
        starSize: 20,
        valueLabelColor: const Color(0xff9b9b9b),
        valueLabelTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 12.0),
        valueLabelRadius: 10,
        maxValue: 5,
        starSpacing: 2,
        maxValueVisibility: true,
        valueLabelVisibility: true,
        animationDuration: const Duration(milliseconds: 1000),
        valueLabelPadding:
            const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
        valueLabelMargin: const EdgeInsets.only(right: 8),
        starOffColor: const Color(0xffe7e8ea),
        starColor: Colors.yellow,
      ),
    );
  }

  createRate() async {
    FocusScope.of(context).unfocus();
    _formKey.currentState?.save();
    final prefs = await SharedPreferences.getInstance();
    var user_Id = prefs.getString('userID');
    var user_Name = prefs.getString('name');

    try {
      await Provider.of<RateProvider>(context, listen: false)
          .createRating(user_Id.toString(), widget.teacherId.toString(),
              user_Name.toString(), value.toString(), comment.text)
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
      print(e);
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red.shade500,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
