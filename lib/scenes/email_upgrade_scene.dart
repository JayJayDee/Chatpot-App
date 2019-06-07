import 'dart:async';
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';

class EmailUpgradeScene extends StatefulWidget {
  @override
  State createState() => _EmailUpgradeSceneState();
}

class _EmailUpgradeSceneState extends State<EmailUpgradeScene> with WidgetsBindingObserver {

  bool _loading;
  String _email;

  String _inputedEmail;
  String _inputedCode;
  String _inputedPassword;
  String _inputedPasswordConfirm;

  ActivationStatus _status;
  bool _passwordInputRequired;
  TextEditingController _controller;

  _EmailUpgradeSceneState() {
    _loading = false;
    _inputedEmail = '';
    _inputedCode = '';
    _passwordInputRequired = false;
    _controller = new TextEditingController();
  }

  Future<void> _loadAndRefreshStatus() async {
    final state = ScopedModel.of<AppState>(context);
    String memberToken = state.member.token;
    setState(() {
      _loading = true;
    });

    var activationStatus = 
      await activationApi().requestAcitvationStatus(
        memberToken: memberToken);

    if (this.mounted) {
      setState(() {
        this._email = activationStatus.email;
        this._status = activationStatus.status;
        this._passwordInputRequired = activationStatus.passwordRequired;
        _loading = false;
      });
      print(this._status);
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

    final state = ScopedModel.of<AppState>(context);
    setState(() {
      this._loading = true;
    });

    try {
      await activationApi().requestEmailActivation(
        email: _inputedEmail,
        memberToken: state.member.token
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
    final state = ScopedModel.of<AppState>(context);

    try {
      await activationApi().requestEmailVerification(
        memberToken: state.member.token,
        activationCode: _inputedCode
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

  Future<void> _onCompletedOkClicked(BuildContext context) async {
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(locales().emailUpgradeScene.title)
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
          color: Styles.primaryFontColor,
          fontSize: 16
        ),
      )
    ),
    Container(
      margin: EdgeInsets.only(left: 10, top: 15, right: 10),
      child: CupertinoTextField(
        prefix: Icon(CupertinoIcons.mail_solid,
          size: 28.0,
          color: CupertinoColors.inactiveGray),
        placeholder: locales().signupScene.emailPlaceHolder,
        onChanged: inputChangedCallback,
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
        keyboardType: TextInputType.emailAddress,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
        ),
        controller: controller,
      )
    ),
    Container(
      margin: EdgeInsets.only(left: 10, top: 15, right: 10),
      child: CupertinoButton(
        child: Text(locales().emailUpgradeScene.emailButtonLabel),
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
              color: Styles.primaryFontColor,
              fontSize: 16
            )
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: CupertinoTextField(
            prefix: Icon(CupertinoIcons.padlock_solid,
              size: 28.0,
              color: CupertinoColors.inactiveGray),
            placeholder: locales().emailUpgradeScene.passwordPlaceholder,
            onChanged: paswordChangedCallback,
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
            )
          )
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: CupertinoTextField(
            prefix: Icon(CupertinoIcons.padlock_solid,
              size: 28.0,
              color: CupertinoColors.inactiveGray),
            placeholder: locales().emailUpgradeScene.passwordConfirmPlaceholder,
            onChanged: paswordConfirmChangedCallback,
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
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
          color: Styles.primaryFontColor,
          fontSize: 16
        ),
      )
    ),
    Container(
      margin: EdgeInsets.only(left: 10, top: 15, right: 10),
      child: CupertinoTextField(
        prefix: Icon(CupertinoIcons.gear,
          size: 28.0,
          color: CupertinoColors.inactiveGray),
        placeholder: locales().emailUpgradeScene.codePlaceHolder,
        onChanged: inputChangedCallback,
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
        keyboardType: TextInputType.text,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
        ),
        controller: controller
      )
    ),
    isPasswordInputRequired == true ? passwordInputWidget : Container(),
    Container(
      margin: EdgeInsets.only(left: 10, top: 15, right: 10),
      child: CupertinoButton(
        child: Text(locales().emailUpgradeScene.codeInputButtonLabel),
        onPressed: loading == true ? null : 
          () => codeInputCallback()
      )
    ),
    Container(
      margin: EdgeInsets.only(left: 10, top: 0, right: 10),
      child: CupertinoButton(
        child: Text(locales().emailUpgradeScene.codeResendButtonLabel),
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
          color: Styles.primaryFontColor,
          fontSize: 16
        ),
      )
    ),
    Container(
      margin: EdgeInsets.only(left: 10, top: 15, right: 10),
      child: CupertinoButton(
        child: Text(locales().emailUpgradeScene.completeOkButtonLabel),
        onPressed: () => okCallback()
      )
    )
  ];
}

Widget _buildProgressBar(bool loading) {
  if (loading == true) return CupertinoActivityIndicator();
  return Center();
}