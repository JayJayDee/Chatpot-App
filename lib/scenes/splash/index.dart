import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/member-model.dart';

class SplashScene extends StatefulWidget {
  @override 
  _SplashState createState() => _SplashState(); 
}

class _SplashState extends State<SplashScene> {
  MemberModel _memberModel;

  @override 
  Widget build(BuildContext context) {
    return ScopedModel<MemberModel>(
      model: _memberModel,
      child: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: FlutterLogo(
                    size: 60.0
                  ),
                  margin: EdgeInsets.all(15.0),
                ),
                Text(
                  'Chatpot',
                  style: TextStyle(
                    fontSize: 25.0
                  )
                ),
                Container(
                  margin: EdgeInsets.all(30.0),
                  child: Opacity(
                    opacity: _memberModel.loading ? 1.0 : 0.0,
                    child: CircularProgressIndicator()
                  )
                )
              ],
            )
          )
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    if (_memberModel == null) _memberModel = MemberModel();
    _memberModel.initialize().then((value) {
      print('authenticate cllabck fired');
    });
  }
}