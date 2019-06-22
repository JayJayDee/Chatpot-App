import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';

class EulaScene extends StatefulWidget {
 
  @override
  State createState() => _EulaSceneState();
}

class _EulaSceneState extends State<EulaScene> {

  bool _loading;
  String _eulaContent;

  _EulaSceneState() {
    _eulaContent = '';
    _loading = false;
  }

  @override
  void initState() {
    super.initState();
    this._loadInitial();
  }

  void _loadInitial() async {
    setState(() {
      _loading = true;
    });

    String eulaContent;

    try {
      eulaContent = await _requestEula('ko');
    } catch (err) {
      if (err is EulaFetchError) {
        await showSimpleAlert(context, locales().eulaScene.eulaFetchError);
        Navigator.of(context).pop();
        return;
      }
    }
    
    setState(() {
      _eulaContent = eulaContent;
      _loading = false;
    });
  }

  void _onAgreeButtonClicked() async {
    Navigator.of(context).pop(true);
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().eulaScene.prevButtonLabel,
        middle: Text(locales().eulaScene.title),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(_eulaContent,
                    style: TextStyle(
                      color: Styles.primaryFontColor,
                      fontSize: 16
                    )
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  child: _buildAgreeButton(context,
                    loading: _loading,
                    callback: () => _onAgreeButtonClicked()
                  )
                )
              ]
            ),
            Positioned(
              child: _buildProgress(_loading)
            )
          ]
        )
      )
    );
  }
}

Widget _buildAgreeButton(BuildContext context, {
  @required bool loading,
  @required VoidCallback callback
}) {
  return CupertinoButton(
    child: Text(locales().eulaScene.agreeButtonLabel),
    color: CupertinoColors.activeBlue,
    onPressed: loading == true ? null : callback,
  );
}

Widget _buildProgress(bool loading) =>
  loading == true ? CupertinoActivityIndicator() :
    Container();

class EulaFetchError extends Error {}

Future<String> _requestEula(String localeCode) async {
  String fallbackLocale = 'en';
  if (localeCode == 'ko' || localeCode == 'en' || localeCode == 'ja') {
    fallbackLocale = localeCode;
  }
  String uri = "http://chatpot.chat/assets/eula-$fallbackLocale.txt";
  var resp = await http.get(uri);
  if (resp.statusCode != 200) {
    throw new EulaFetchError();
  }
 return resp.body;
}