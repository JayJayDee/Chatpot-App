import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';

import 'package:chatpot_app/scenes/splash_scene.dart';
import 'package:chatpot_app/scenes/login_scene.dart';
import 'package:chatpot_app/scenes/signup_simple_scene.dart';

void main() {
  initFactory();
  runApp(
    ScopedModel<AppState>(
      model: AppState(),
      child: CupertinoApp(
        color: Styles.appBackground,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScene(),
          '/login': (context) => LoginScene(),
          '/signup/simple': (context) => SimpleSignupScene()
        }
      )
    )
  );
}