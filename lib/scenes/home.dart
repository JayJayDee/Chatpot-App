import 'package:flutter/material.dart';

class HomeScene extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatpot'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Go TO Login'),
          onPressed: () {
            print('clicked on home');
            Navigator.pushNamed(context, '/login');
          },
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home')
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.chat),
            title: new Text('Chats')
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('Profile')
          )
        ],
      ),
    );
  }
}