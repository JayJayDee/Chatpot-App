import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/member-model.dart';

class SplashLoadingIndicator extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MemberModel>(
      builder: (context, child, model) {
        if (model.loading == true) {
          return CircularProgressIndicator(value: 50.0);
        } else {
          return null;
        }
      }
    );
  }
}