import 'package:flutter/material.dart';

class MyScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MySceneState();
}

class _MySceneState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My')
      ),
      body: Center(
        child: Text('My')
      ),
    );
  } 
}