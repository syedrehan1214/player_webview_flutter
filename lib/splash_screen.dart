import 'dart:async';
import 'package:flutter/material.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  checkUser() async {
    var duration = const Duration(seconds: 3);

    Timer(duration, () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/splash.png',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
