import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/member-model.dart';

class SplashScene extends StatelessWidget {

  @override
  build(BuildContext context) {
    initScene(context);
    return Scaffold(
      body: Center(
        child: ScopedModel<MemberModel>(
          model: MemberModel.getInstance(),
          child: ScopedModelDescendant<MemberModel>(
            builder: (context, child, model) {
              if (model.loading == true) {
                return CircularProgressIndicator(
                  value: 50.0
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Sign in'),
                    onPressed: () {} 
                  ),
                  RaisedButton(
                    child: Text('Start without sign-up'),
                    onPressed: () {}
                  )
                ],
              );
            }
          ),
        )
      )
    );
  }

  void initScene (BuildContext context) async {
    Locale locale = Localizations.localeOf(context);
    await MemberModel.getInstance().tryAutoLogin(locale);
  }
}