import 'package:flutter/material.dart';
import './home.dart';

class SplashScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Click me'),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScene()));
            print('clicked');
          },
        )
      )
    );
  }
}