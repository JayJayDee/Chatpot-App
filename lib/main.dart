import 'package:flutter/material.dart';
import './scenes/splash.dart';
import './scenes/home.dart';
import './scenes/login.dart';

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
        '/home': (context) => HomeScene(),
        '/login': (conext) => LoginScene()
      }
    );
  }
}