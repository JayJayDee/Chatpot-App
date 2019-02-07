import 'package:flutter/material.dart';

class HomeScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeSceneState();
}

class _HomeSceneState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: Center(
        child: Text('Home')
      ),
    );
  } 
}