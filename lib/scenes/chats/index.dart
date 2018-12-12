import 'package:flutter/material.dart';

class ChatsScene extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    print('chats-scene');
    return Center(
      child: Container(
        color: Colors.amber,
        child: Text('THIS IS chat')
      )
    );
  }
}