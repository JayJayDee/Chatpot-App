import 'package:flutter/material.dart';
import 'package:chatpot_app/scenes/home-scene.dart';
import 'package:chatpot_app/scenes/chats-scene.dart';
import 'package:chatpot_app/scenes/my-scene.dart';

class HomeContainerScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeContainerSceneState();
}

class _HomeContainerSceneState extends State<HomeContainerScene> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScene(),
    ChatsScene(),
    MyScene()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            title: Text('Chats')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_location),
            title: Text('My')
          ),
        ],
        onTap: onTabSelected,
      ),
      body: _children[_currentIndex]
    );
  }

  void onTabSelected(int idx) {
    setState(() {
      _currentIndex = idx;
    });
  }
}