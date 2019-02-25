import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildNotLoginCard(BuildContext context, {
  VoidCallback loginSelectCallback
}) {
  return Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('You\'re not logged in.')
        ],
      ),
    ),
  );
}