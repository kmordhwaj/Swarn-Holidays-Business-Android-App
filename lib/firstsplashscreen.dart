import 'dart:async';
import 'package:flutter/material.dart';
import 'loginscreen.dart';
import 'package:shimmer/shimmer.dart';

class FirstSplashScreen extends StatefulWidget {
  const FirstSplashScreen({Key? key}) : super(key: key);

  @override
  _FirstSplashScreenState createState() => _FirstSplashScreenState();
}

class _FirstSplashScreenState extends State<FirstSplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LogInScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.deepPurple.shade900, Colors.pink.shade900])),
        child: Center(
          child: SizedBox(
            width: 280,
            height: 180,
            child: Shimmer.fromColors(
                highlightColor: Colors.red,
                baseColor: Colors.green,
                child: Image.asset(
                  'assets/images/logob.png',
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
