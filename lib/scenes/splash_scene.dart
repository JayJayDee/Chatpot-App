import 'package:flutter/material.dart';

class SplashScene extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() => SplashSceneState();
}

class SplashSceneState extends State<SplashScene> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatpot'),
      ),
      body: Center()
    );
  }
}