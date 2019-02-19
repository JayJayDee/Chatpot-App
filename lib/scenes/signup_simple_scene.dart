import 'package:flutter/cupertino.dart';

class SimpleSignupScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Back',
        middle: Text('Start without sign-up'),
      ),
      child: SafeArea(
        child: Column(
          
        ),
      )
    );
  } 
}