import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatpot_app/styles.dart';

class HomeScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text('Home')
      // ),
      child: SafeArea(
        child: ListView(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Center()
              )
            ]
          )
        ])
      )
    );
  }
}