import 'package:flutter/material.dart';

class SignupScene extends StatelessWidget {

  bool _initCalled = false;

  void _init(BuildContext context) async {
    if (_initCalled == true) return;
    print('* signup-scene init');
  }

  @override
  Widget build(BuildContext context) {
    _init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up')
      ),
    );
  }
}