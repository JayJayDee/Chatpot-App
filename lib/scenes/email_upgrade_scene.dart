import 'dart:async';
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';

class EmailUpgradeScene extends StatefulWidget {
  @override
  State createState() => _EmailUpgradeSceneState();
}

class _EmailUpgradeSceneState extends State<EmailUpgradeScene> with WidgetsBindingObserver {

  bool _loading;
  String _email;
  ActivationStatus _status;

  _EmailUpgradeSceneState() {
    _loading = false;
  }

  Future<void> _loadAndRefreshStatus() async {
    final state = ScopedModel.of<AppState>(context);
    String memberToken = state.member.token;
    setState(() {
      _loading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    var activationStatus = 
      await activationApi().requestAcitvationStatus(
        memberToken: memberToken);

    if (this.mounted) {
      setState(() {
        this._email = activationStatus.email;
        this._status = activationStatus.status;
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
              children: [
                Text('asdfsa')
              ],
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

Widget _buildProgressBar(bool loading) {
  if (loading == true) return CupertinoActivityIndicator();
  return Center();
}