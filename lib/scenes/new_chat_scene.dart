import 'package:flutter/cupertino.dart';

class NewChatScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Back',
        middle: Text('New chat'),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Center(

        )
      )
    );
  }  
}