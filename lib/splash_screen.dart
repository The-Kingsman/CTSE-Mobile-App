import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teach_rate/models/User.dart';
import 'package:teach_rate/providers/UserProvider.dart';
import 'package:teach_rate/screens/auth/signin_screen.dart';
import 'package:teach_rate/screens/teacher/teachers_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late List<dynamic> colors;
  late int position;
  late AnimationController _animationController;

  @override
  void initState() {
    position = 0;
    colors = [
      Colors.orangeAccent,
      Colors.orange,
      Colors.red,
      Colors.deepPurpleAccent,
      Colors.deepPurple,
      Colors.blue,
      Colors.teal
    ];
    changeColor();

    super.initState();
    _animationController = AnimationController(vsync: this);
    _animationController.addListener(() {
      if (_animationController.value > 1) {
        _animationController.value = 1;
      }
    });
    Future.delayed(
      const Duration(seconds: 2),
      () {
        performAutoLogin();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SpinKitFadingCube(
            color: colors[position],
            size: 80,
          ),
        ),
      ),
    );
  }

  changeColor() {
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          if (position < 6) {
            position++;
          } else {
            position = 0;
          }
        });
        changeColor();
      }
    });
  }

  performAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      User user =
          User.fromJson(json.decode(prefs.getString('user').toString()));
      signIn(user.email, user.password);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }

  signIn(
    email,
    password,
  ) async {
    FocusScope.of(context).unfocus();
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .signIn(
        email,
        password,
      )
          .then(
        (result) async {
          if (result['result'] is String) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ),
            );
          } else {
            final user = User(
              id: result['result']['_id'],
              name: result['result']['name'],
              email: result['result']['email'],
              age: result['result']['age'],
              contact: result['result']['contact'],
              password: result['result']['password'],
              role: result['result']['role'],
            );
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('userID', result['result']['_id']);
            prefs.setString('user', json.encode(user));
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            ),
          );
        },
      );
    } catch (e) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }
}
