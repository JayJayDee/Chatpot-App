import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';

class ReportScene extends StatefulWidget {
  @override
  State createState() => _ReportSceneState();
}

class _ReportSceneState extends State<ReportScene> {

  bool _loading;

  _ReportSceneState() {
    _loading = false;    
  }

  void _onSubmitButtonClicked(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().reportScene.prevButtonLabel,
        middle: Text(locales().reportScene.title),
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              children: [
                _buildReportButton(context,
                  loading: _loading,
                  callback: () => _onSubmitButtonClicked(context)
                )
              ]
            ),
            _buildProgress(context, loading: _loading)
          ]
        )
      ),
    );
  }
}

Widget _buildProgress(BuildContext context, {
  @required bool loading
}) =>
  loading == true ? Container() :
    CupertinoActivityIndicator();

Widget _buildReportButton(BuildContext context, {
  @required bool loading,
  @required VoidCallback callback
}) {
  return CupertinoButton(
    child: Text(locales().reportScene.reportButtonLabel),
    onPressed: loading == true ? null : callback,
    color: CupertinoColors.activeBlue
  );
}