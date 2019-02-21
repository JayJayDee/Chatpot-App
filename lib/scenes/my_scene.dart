import 'package:flutter/cupertino.dart';

class MyScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('My profile')
      ),
      child: Center()
    );
  }
}