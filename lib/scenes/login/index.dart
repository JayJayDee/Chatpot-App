import 'package:flutter/material.dart';

class LoginScene extends StatelessWidget {
  @override 
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in to Chatpot')
      ),
      body: Center(
        child: Text('sign-in screeen')
      )
    );
  }
}