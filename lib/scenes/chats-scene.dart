import 'package:flutter/material.dart';

class ChatsScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatsSceneState();
}

class _ChatsSceneState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats')
      ),
      body: Center(
        child: Text('Chats')
      ),
    );
  } 
}