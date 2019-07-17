import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:chatpot_app/models/app_state.dart';


class EmailUpgradeScene extends StatefulWidget {

  final String memberToken;

  EmailUpgradeScene({
    @required this.memberToken
  });

  @override
  State createState() => _EmailUpgradeSceneState(memberToken: memberToken);
}

class _EmailUpgradeSceneState extends State<EmailUpgradeScene> with WidgetsBindingObserver {

  bool _loading;
  String _email;
  String _memberToken;

  String _inputedEmail;
  String _inputedCode;
  String _inputedPassword;
  String _inputedPasswordConfirm;

  ActivationStatus _status;
  bool _passwordInputRequired;
  TextEditingController _controller;

  _EmailUpgradeSceneState({
    @required String memberToken
  }) {
    _memberToken = memberToken;
    _loading = false;
    _inputedEmail = '';
    _inputedCode = '';
    _passwordInputRequired = false;
    _controller = new TextEditingController();
  }

  Future<void> _loadAndRefreshStatus() async {
    setState(() {
      _loading = true;
    });

    var activationStatus = 
      await activationApi().requestAcitvationStatus(
        memberToken: _memberToken);

    if (this.mounted) {
      setState(() {
        this._email = activationStatus.email;
        this._status = activationStatus.status;
        this._passwordInputRequired = activationStatus.passwordRequired;
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAndRefreshStatus();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Future.delayed(Duration.zero).then((data) {
      if (state == AppLifecycleState.resumed) {
        _loadAndRefreshStatus();
      }
    });
  }

  Future<void> _onEmailInputed(BuildContext context) async {
    if (_inputedEmail.trim().length == 0) {
      await showSimpleAlert(context, locales().emailUpgradeScene.emailRequired);
      return;
    }

    setState(() {
      this._loading = true;
    });

    try {
      await activationApi().requestEmailActivation(
        email: _inputedEmail,
        memberToken: _memberToken
      );
      _loadAndRefreshStatus();

    } catch (err) {
      setState(() {
        this._loading = false;
      });
      if (err is ApiFailureError) {
        await showSimpleAlert(context,
          locales().error.messageFromErrorCode(err.code));
      }
    } finally {
      _controller.clear();
    }
  }

  Future<void> _onCodeInputed(BuildContext context) async {
    if (_inputedCode.trim().length == 0) {
      await showSimpleAlert(context, locales().emailUpgradeScene.emailRequired);
      return;
    }

    if (_passwordInputRequired == true) {
      if (_inputedPassword.trim().length == 0) {
        await showSimpleAlert(context, locales().emailUpgradeScene.passwordRequired);
        return;
      }
      if (_inputedPasswordConfirm.trim().compareTo(_inputedPassword.trim()) != 0) {
        await showSimpleAlert(context, locales().emailUpgradeScene.passwordNotMatch);
        return;
      }
    }

    setState(() {
      this._loading = true;
    });

    try {
      await activationApi().requestEmailVerification(
        memberToken: _memberToken,
        activationCode: _inputedCode,
        password: _inputedPassword
      );
      _loadAndRefreshStatus();
      final state = ScopedModel.of<AppState>(context);
      await state.refreshProfile();
    } catch (err) {
      setState(() {
        this._loading = false;
      });
      if (err is ApiFailureError) {
        await showSimpleAlert(context,
          locales().error.messageFromErrorCode(err.code));
      } else {
        throw err;
      }
    } finally {
      _controller.clear();
    }
  }

  Future<void> _onCompletedOkClicked(BuildContext context) async {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: styles().mainBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(locales().emailUpgradeScene.title,
          style: TextStyle(
            color: styles().primaryFontColor
          )
        ),
        actionsForegroundColor: styles().link,
        backgroundColor: styles().navigationBarBackground,
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              children: 
                this._status == ActivationStatus.IDLE ? 
                  _buildEmailInputWidgets(
                    loading: _loading,
                    controller: _controller,
                    inputChangedCallback: (String inputed) => _inputedEmail = inputed,
                    emailInputCallback: () => _onEmailInputed(context)) :

                this._status == ActivationStatus.SENT ?
                  _buildCodeInputWidgets(
                    loading: _loading,
                    isPasswordInputRequired: _passwordInputRequired,
                    controller: _controller,
                    email: _email,
                    inputChangedCallback: (String inputed) => _inputedCode = inputed,
                    paswordChangedCallback: (String inputed) => _inputedPassword = inputed,
                    paswordConfirmChangedCallback: (String inputed) => _inputedPasswordConfirm = inputed,
                    codeInputCallback: () => _onCodeInputed(context)) :

                this._status == ActivationStatus.CONFIRMED ?
                  _buildCompletedWidgets(
                    email: _email,
                    okCallback: () => _onCompletedOkClicked(context)
                  ) :
                []
            ),
            Positioned(
              child: _buildProgressBar(this._loading)
            )
          ]
        )
      )
    );
  }
}


typedef StringInputCallback (String inputed);

List<Widget> _buildEmailInputWidgets({
  @required bool loading,
  @required VoidCallback emailInputCallback,
  @required StringInputCallback inputChangedCallback,
  @required TextEditingController controller
}) {
  return [
    Container(
      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Text(locales().emailUpgradeScene.emailInput,
        style: TextStyle(
          color: styles().primaryFontColor,
          fontSize: 16
        ),
      )
    ),
    Container(
      margin: EdgeInsets.only(left: 10, top: 15, right: 10),
      child: CupertinoTextField(
        prefix: Icon(CupertinoIcons.mail_solid,
          size: 28.0,
          color: styles().editTextHint),
        placeholder: locales().signupScene.emailPlaceHolder,
        placeholderStyle: TextStyle(
          color: styles().editTextHint
        ),
        onChanged: inputChangedCallback,
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
        keyboardType: TextInputType.emailAddress,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
        ),
        controller: controller,
        style: TextStyle(
          color: styles().editTextFont
        )
      )
    ),
    Container(
      margin: EdgeInsets.only(left: 10, top: 15, right: 10),
      child: CupertinoButton(
        child: Text(locales().emailUpgradeScene.emailButtonLabel,
          style: TextStyle(
            color: styles().link
          ),
        ),
        onPressed: loading == true ? null : 
          () => emailInputCallback()
      )
    )
  ];
}

List<Widget> _buildCodeInputWidgets({
  @required String email,
  @required bool isPasswordInputRequired,
  @required bool loading,
  @required VoidCallback codeInputCallback,
  @required StringInputCallback inputChangedCallback,
  @required StringInputCallback paswordChangedCallback,
  @required StringInputCallback paswordConfirmChangedCallback,
  @required TextEditingController controller
}) {
  Widget passwordInputWidget = Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 30),
          child: Text(locales().emailUpgradeScene.passwordInput,
            style: TextStyle(
              color: styles().primaryFontColor,
              fontSize: 16
            )
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: CupertinoTextField(
            prefix: Icon(CupertinoIcons.padlock_solid,
              size: 28.0,
              color: styles().editTextHint),
            placeholder: locales().emailUpgradeScene.passwordPlaceholder,
            placeholderStyle: TextStyle(
              color: styles().editTextHint
            ),
            onChanged: paswordChangedCallback,
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
            ),
            style: TextStyle(
              color: styles().editTextFont
            )
          )
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: CupertinoTextField(
            prefix: Icon(CupertinoIcons.padlock_solid,
              size: 28.0,
              color: styles().editTextHint),
            placeholder: locales().emailUpgradeScene.passwordConfirmPlaceholder,
            placeholderStyle: TextStyle(
              color: styles().editTextHint
            ),
            onChanged: paswordConfirmChangedCallback,
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
            ),
            style: TextStyle(
              color: styles().editTextFont
            )
          )
        )
      ]
    )
  );

  return [
    Container(
      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Text(locales().emailUpgradeScene.codeInput(email),
        style: TextStyle(
          color: styles().primaryFontColor,
          fontSize: 16
        ),
      )
    ),
    Container(
      margin: EdgeInsets.only(left: 10, top: 15, right: 10),
      child: CupertinoTextField(
        prefix: Icon(CupertinoIcons.gear,
          size: 28.0,
          color: styles().editTextHint),
        placeholder: locales().emailUpgradeScene.codePlaceHolder,
        placeholderStyle: TextStyle(
          color: styles().editTextHint
        ),
        onChanged: inputChangedCallback,
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
        keyboardType: TextInputType.text,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
        ),
        controller: controller,
        style: TextStyle(
          color: styles().editTextFont
        )
      )
    ),
    isPasswordInputRequired == true ? passwordInputWidget : Container(),
    Container(
      margin: EdgeInsets.only(left: 10, top: 15, right: 10),
      child: CupertinoButton(
        child: Text(locales().emailUpgradeScene.codeInputButtonLabel,
          style: TextStyle(
            color: styles().link
          )
        ),
        onPressed: loading == true ? null : 
          () => codeInputCallback()
      )
    ),
    Container(
      margin: EdgeInsets.only(left: 10, top: 0, right: 10),
      child: CupertinoButton(
        child: Text(locales().emailUpgradeScene.codeResendButtonLabel,
          style: TextStyle(
            color: styles().link
          )
        ),
        onPressed: loading == true ? null : 
          () => {}
      )
    )
  ];
}

List<Widget> _buildCompletedWidgets({
  @required String email,
  @required VoidCallback okCallback
}) {
  return [
    Container(
      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Text(locales().emailUpgradeScene.completed(email),
        style: TextStyle(
          color: styles().primaryFontColor,
          fontSize: 16
        ),
      )
    ),
    Container(
      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Text(locales().emailUpgradeScene.completed2,
        style: TextStyle(
          color: styles().primaryFontColor,
          fontSize: 16
        )
      )
    ),
    Container(
      margin: EdgeInsets.only(left: 10, top: 15, right: 10),
      child: CupertinoButton(
        child: Text(locales().emailUpgradeScene.completeOkButtonLabel,
          style: TextStyle(
            color: styles().link
          )
        ),
        onPressed: () => okCallback()
      )
    )
  ];
}

Widget _buildProgressBar(bool loading) {
  if (loading == true) return CupertinoActivityIndicator();
  return Center();
}