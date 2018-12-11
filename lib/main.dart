import 'package:flutter/material.dart';
import './scenes/splash/index.dart';
import './scenes/home-tabs.dart';
import './scenes/login/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatpot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScene(),
        '/home': (context) => HomeTabsScene(),
        '/login': (conext) => LoginScene()
      }
    );
  }
}