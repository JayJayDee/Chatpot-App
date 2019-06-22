import 'package:chatpot_app/apis/api_errors.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';

class ReportScene extends StatefulWidget {

  final String targetToken;

  ReportScene({
    this.targetToken
  });

  @override
  State createState() => _ReportSceneState();
}

class _ReportSceneState extends State<ReportScene> {

  String _targetToken;
  bool _loading;

  _ReportSceneState({
    @required String targetToken
  }) {
    _targetToken = targetToken;
    _loading = false;    
  }

  void _onSubmitButtonClicked(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    try {
      // TODO: api call & exception handling.
    } catch (err) {
      if (err is ApiFailureError) {
        await showSimpleAlert(context, locales().error.messageFromErrorCode(err.code));
        return;
      }
    } finally {
      setState(() {
        _loading = false;
      });
    }
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