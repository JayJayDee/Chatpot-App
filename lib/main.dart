import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/locale_delegate.dart';

import 'package:chatpot_app/scenes/splash_scene.dart';
import 'package:chatpot_app/scenes/login_scene.dart';
import 'package:chatpot_app/scenes/signup_simple_scene.dart';
import 'package:chatpot_app/scenes/container_scene.dart';

void main() {
  initFactory();
  runApp(
    OKToast(
      child: ScopedModel<AppState>(
        model: AppState(),
        child: CupertinoApp(
          debugShowCheckedModeBanner: false,
          color: styles().appBackground,
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScene(),
            '/login': (context) => LoginScene(),
            '/container': (context) => ContainerScene(),
            '/signup/simple': (context) => SimpleSignupScene()
          },
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('ko', 'KR'),
            const Locale('ja', 'JP')
          ],
          localizationsDelegates: [
            const FallbackCupertinoLocalisationsDelegate(),
            const FallbackMaterialLocalizationDelegate()
          ]
        )
      )
    )
  );
}