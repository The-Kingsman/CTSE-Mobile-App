import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => login(),
        //   ),
        // );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xff2e2e91),
      ),
    );
  }
}
