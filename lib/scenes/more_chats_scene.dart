import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';

@immutable
class MoreChatsScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Back',
        middle: Text('More chats'),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Center()
      )
    );
  }
}