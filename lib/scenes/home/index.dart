import 'package:flutter/material.dart';
import 'package:chatpot_app/widgets/my-nick.dart';

class HomeScene extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    print('home-scene');
    return Center(
      child: MyNickView()
    );
  }
}