import 'package:flutter/material.dart';

class SimpleGenderScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your gender'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('Male'),
                  onPressed: () => Navigator.pop(context, 'M')
                ),
                RaisedButton(
                  child: Text('Female'),
                  onPressed: () => Navigator.pop(context, 'F')
                )
              ],
            )
          ]
        )
      )
    );
  }
}