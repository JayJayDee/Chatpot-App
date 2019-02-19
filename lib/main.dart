import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/scenes/container_scene.dart';

void main() {
  initFactory();
  runApp(
    ScopedModel<AppState>(
      model: AppState(),
      child: CupertinoApp(
        color: Styles.appBackground,
        home: ContainerScene()
      )
    )
  );
}