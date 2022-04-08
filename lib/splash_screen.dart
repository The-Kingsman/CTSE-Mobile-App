import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:teach_rate/screens/auth/signin_screen.dart';

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
      const Duration(seconds: 4),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        );
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
}
