import 'package:flutter/material.dart';

class SplashScene extends StatefulWidget {
  @override
  _SplashSceneState createState() => _SplashSceneState();
}

class _SplashSceneState extends State<SplashScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('호옹!'),
      ),
    );
  }
}