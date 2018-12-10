import 'package:flutter/material.dart';
import 'package:chatpot_app/scenes/home/index.dart';
import 'package:chatpot_app/scenes/chats/index.dart';
import 'package:chatpot_app/scenes/profile/index.dart';

class HomeTabsScene extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabsScene> {
  int _currentIdx = 0;
  final List<Widget> _children = [
    HomeScene(),
    ChatsScene(),
    ProfileScene()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatpot-Dev')
      ),
      body: _children[_currentIdx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIdx,
        onTap: (int idx) {
          setState(() {
            _currentIdx = idx;
          });
        },
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