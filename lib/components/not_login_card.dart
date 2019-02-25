import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildNotLoginCard(BuildContext context, {
  VoidCallback loginSelectCallback
}) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Icon(Icons.info_outline, color: CupertinoColors.inactiveGray),
            Padding(padding: EdgeInsets.only(top: 5)),
            Text('You\'re not logged in', textScaleFactor: 1.3),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text('Please sign in to Chatpot to use service',
              style: TextStyle(color: CupertinoColors.inactiveGray)
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            CupertinoButton(
              child: Text('Sign in'),
              onPressed: loginSelectCallback,
              color: CupertinoColors.activeBlue,
            )
          ]
        )
      )
    )
  );
}