import 'package:flutter/material.dart';

class LoginScene extends StatelessWidget {
  @override 
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in to Chatpot')
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text('Please sign in to chatpot, or you can use without sign-in', textAlign: TextAlign.left)
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    hintText: 'your email',
                  ),
                )
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12.0),
                    border: OutlineInputBorder(),
                    hintText: 'password'
                  ),
                  obscureText: true,
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text('Sign in'),
                    onPressed: () {

                    }
                  )
                ) 
              )
            ],
          ),
        )
      )
    );
  }
}