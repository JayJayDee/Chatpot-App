import 'package:flutter/cupertino.dart';

class HomeScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home')
      ),
      child: Center()
    );
  }
}