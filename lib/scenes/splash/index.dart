import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/member-model.dart';

class SplashScene extends StatefulWidget {
  @override 
  _SplashState createState() => _SplashState(); 
}

class _SplashState extends State<SplashScene> 
  with WidgetsBindingObserver {
  
  @override 
  Widget build(BuildContext context) {
    MemberModel memberModel = MemberModel();

    return ScopedModel<MemberModel>(
      model: memberModel,
      child: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
                  margin: EdgeInsets.all(25.0),
                  child: Visibility(
                    visible: memberModel.loading,
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print('app resumed!');
    } else if (state == AppLifecycleState.paused) {
      print('app paused');
    }
  }

  @override
  void initState() {
    super.initState();
    print('splash-scene started');
    WidgetsBinding.instance.addObserver(this);
  }

  @override 
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}