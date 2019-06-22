import 'package:chatpot_app/apis/api_errors.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/entities/report.dart';
import 'package:chatpot_app/components/report_type_selector.dart';
import 'package:chatpot_app/styles.dart';

class ReportScene extends StatefulWidget {

  final String targetToken;

  ReportScene({
    this.targetToken
  });

  @override
  State createState() =>
    _ReportSceneState(
      targetToken: targetToken
    );
}

class _ReportSceneState extends State<ReportScene> {

  String _targetToken;
  MemberPublic _targetMember;
  bool _loading;

  ReportType _reportType;

  _ReportSceneState({
    @required String targetToken
  }) {
    _targetToken = targetToken;
    _loading = false;    
    _reportType = null;
  }

  @override
  void initState() {
    super.initState();
    this._loadMemberInfo();
  }

  void _loadMemberInfo() async {
    setState(() {
      _loading = true;
    });

    MemberPublic fetched = await memberApi().requestMemberPublic(
      memberToken: _targetToken
    );

    setState(() {
      _loading = false;
      _targetMember = fetched;
    });
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
      } else {
        throw err;
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
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(locales().reportScene.description1,
                    style: TextStyle(
                      color: Styles.primaryFontColor,
                      fontSize: 16
                    )
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: _buildTargetMemberWidget(context,
                    member: _targetMember
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(locales().reportScene.description2,
                    style: TextStyle(
                      color: Styles.primaryFontColor,
                      fontSize: 16
                    )
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: builReportTypeSeletor(context,
                    reportType: _reportType,
                    reportSelectCallback: (ReportType type) {
                      setState(() {
                        _reportType = type;
                      });
                    }
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: _buildReportButton(context,
                    loading: _loading,
                    callback: () => _onSubmitButtonClicked(context)
                  )
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
  loading == false ? Container() :
    CupertinoActivityIndicator();

Widget _buildTargetMemberWidget(BuildContext context, {
  @required MemberPublic member
}) =>
  member == null ? 
    Center(child: CupertinoActivityIndicator()) :
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(right: 15),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: CachedNetworkImage(
                  imageUrl: member.avatar.thumb,
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                )
              ),
              Positioned(
                child: Container(
                  width: 30,
                  height: 15,
                  decoration: BoxDecoration(
                    border: Border.all(color: Styles.primaryFontColor),
                    image: DecorationImage(
                      image: locales().getFlagImage(member.region),
                      fit: BoxFit.cover
                    )
                  )
                )
              )
            ]
          )
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(locales().getNick(member.nick),
                style: TextStyle(
                  color: Styles.primaryFontColor,
                  fontSize: 17
                )
              ),
              Text(member.regionName,
                style: TextStyle(
                  color: Styles.secondaryFontColor,
                  fontSize: 16
                )
              )
            ]
          )
        )
      ]
    );

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