import 'package:flutter/cupertino.dart';

class ChatsScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Chats')
      ),
      child: Center()
    );
  }
}