import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:chatpot_app/scenes/splash-scene.dart';
import 'package:chatpot_app/scenes/signup-scene.dart';
import 'package:chatpot_app/scenes/home-container-scene.dart';
import 'package:chatpot_app/scenes/signup/simple-gender-scene.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatpot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/signup': (context) => SignupScene(),
        '/splash': (context) => SplashScene(),
        '/': (context) => HomeContainerScene(),
        '/signup/simple-gender': (context) => SimpleGenderScene()
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ko', 'KR'),
        const Locale('ja', 'JP')
      ],
    );
  }
}