import 'dart:async';

import 'package:flutter/material.dart';
import '/src/features/todo_screen/presentation/todo_screen.dart';

class SplashTodoScreen extends StatefulWidget {
  const SplashTodoScreen({
    super.key,
  });

  @override
  SplashTodoScreenState createState() => SplashTodoScreenState();
}

class SplashTodoScreenState extends State<SplashTodoScreen> {

  @override
  void initState() {
    super.initState();
    // Navigate to the home page after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const TodoScreen()),
            (Route<dynamic> route) => false,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/splashImage.png",
            ),
          )
        ],
      ),
    );
  }
}
