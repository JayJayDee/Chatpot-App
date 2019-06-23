import 'dart:async';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/report.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';

class ReportHistoryScene extends StatefulWidget {

  @override
  State createState() => _ReportHistorySceneState();
}

class _ReportHistorySceneState extends State<ReportHistoryScene> {

  bool _loading;
  List<ReportStatus> _reports;

  _ReportHistorySceneState() {
    _loading = false;
    _reports = List();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () =>
      this._loadInitialHistories());
  }

  void _loadInitialHistories() async {
    setState(() => _loading = true);
    final state = ScopedModel.of<AppState>(context);
    String memberToken = state.member.token;

    try {
      List<ReportStatus> reports = await reportApi().requestMyReports(
        memberToken: memberToken
      );
      setState(() => _reports = reports);
    } catch (err) {
      if (err is ApiFailureError) {
        await showSimpleAlert(context, locales().error.messageFromErrorCode(err.code));
        Navigator.of(context).pop();
      } 
    } finally {
      setState(() => _loading = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().setting.title,
        middle: Text(locales().reportHistoryScene.title),
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              children: []
            ),
            _buildProgress(context, loading: _loading)
          ]
        )
      )
    );
  }
}

Widget _buildProgress(BuildContext context, {
  @required bool loading
}) =>
  loading == true ? CupertinoActivityIndicator() :
  Container();