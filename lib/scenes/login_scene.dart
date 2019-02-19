import 'package:flutter/cupertino.dart';

String _email;
String _password;

class LoginScene extends StatelessWidget {

  void _onLoginSubmit() {
    print(_email);
    print(_password);
  }

  void _onSimpleSignUp(BuildContext context) async {
    var resp = await Navigator.pushNamed(context, '/signup/simple');
    print(resp);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Back',
        middle: Text('Sign in')
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
                        onPressed: _onLoginSubmit
                      )
                    ),
                    Container(
                      child: CupertinoButton(
                        child: Text('Start without Sign-up'),
                        onPressed: () => _onSimpleSignUp(context)
                      )
                    ),
                    Container(
                      child: CupertinoButton(
                        child: Text('Sign up'),
                        onPressed: null
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