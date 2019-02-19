import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/styles.dart';

class SplashScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.appBackground,
      child: Center(
        child: Text('Test App'),
      ),
    );
  }
}