import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/styles.dart';

class ChatsScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text('Chats')
      // ),
      child: Center()
    );
  }
}