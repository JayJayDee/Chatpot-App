import 'package:flutter/material.dart';

class HomeScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatpot'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('click me to back'),
          onPressed: () {
            print('clicked on home');
            Navigator.pop(context);
          },
        )
      )
    );
  }
}