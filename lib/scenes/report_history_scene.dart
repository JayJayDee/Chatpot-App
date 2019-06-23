import 'dart:async';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/report.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:chatpot_app/components/report_row.dart';
import 'package:chatpot_app/styles.dart';

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

    widgets.addAll(_buildReportRows(this._reports));

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().setting.title,
        middle: Text(locales().reportHistoryScene.title),
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _loading == false && _reports.length == 0 ? 
              _buildEmptyIndicator() : ListView(children: widgets),
            _buildProgress(context, loading: _loading)
          ]
        )
      )
    );
  }
}

Widget _buildEmptyIndicator() =>
  Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 90,
          child: Image(
            image: AssetImage('assets/chatpot-logo-only-800-grayscale.png')
          )
        ),
        Text(locales().reportHistoryScene.emptyReports,
          style: TextStyle(
            color: Styles.primaryFontColor,
            fontSize: 16
          )
        )
      ]
    ),
  );

List<Widget> _buildReportRows(List<ReportStatus> reports) =>
  reports.map((r) =>
    ReportRow(report: r)
  ).toList();

Widget _buildProgress(BuildContext context, {
  @required bool loading
}) =>
  loading == true ? CupertinoActivityIndicator() :
  Container();