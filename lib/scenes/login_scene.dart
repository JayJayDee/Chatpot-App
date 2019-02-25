import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

String _email = '';
String _password = '';

class LoginScene extends StatelessWidget {

  void _showErrorToast(BuildContext context, String msg) =>
    Toast.show(msg, context);

  void _onLoginSubmit(BuildContext context) {
    if (_email.trim().length == 0) {
      _showErrorToast(context, 'Email requied');
      return;
    }
    if (_password.trim().length == 0) {
      _showErrorToast(context, 'Password required');
      return;
    }
  }

  void _onSimpleSignUp(BuildContext context) async {
    var resp = await Navigator.pushNamed(context, '/signup/simple');
    if (resp == true) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Back',
        middle: Text('Sign in'),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Text("Please sign in for using Chatpot.\nOr, you can just start Chatpot without sign up.")
            ),
            Expanded(
              child: SizedBox(
                width: 500,
                child: ListView(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  children: <Widget>[
                    _buildLoginField(context, (String value) => _email = value),
                    _buildPasswordField(context, (String value) => _password = value),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: CupertinoButton(
                        child: Text('Sign in'),
                        color: CupertinoColors.activeBlue,
                        onPressed: () => _onLoginSubmit(context)
                      )
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: CupertinoButton(
                        child: Text('Start without Sign-up'),
                        color: CupertinoColors.activeGreen,
                        onPressed: () => _onSimpleSignUp(context)
                      )
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: CupertinoButton(
                        child: Text('Sign up'),
                        onPressed: () {

                        }
                      )
                    )
                  ],
                )
              )
            )
          ],
        ),
      )
    );  
  }
}

Widget _buildLoginField(BuildContext context, ValueChanged<String> valueChange) => CupertinoTextField(
  prefix: Icon(
    CupertinoIcons.mail_solid,
    color: CupertinoColors.lightBackgroundGray,
    size: 28.0
  ),
  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
  placeholder: 'Email address',
  keyboardType: TextInputType.emailAddress,
  decoration: BoxDecoration(
    border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
  ),
  onChanged: valueChange,
);

Widget _buildPasswordField(BuildContext context, ValueChanged<String> valueChange) => CupertinoTextField(
  prefix: Icon(
    CupertinoIcons.person_solid,
    color: CupertinoColors.lightBackgroundGray,
    size: 28.0
  ),
  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
  placeholder: 'Password',
  keyboardType: TextInputType.text,
  obscureText: true,
  decoration: BoxDecoration(
    border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
  ),
  onChanged: valueChange
);