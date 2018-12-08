import 'package:flutter/material.dart';

class SplashScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Click me'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        )
      )
    );
  }
}