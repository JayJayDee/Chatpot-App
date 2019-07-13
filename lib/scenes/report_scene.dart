import 'package:chatpot_app/apis/api_errors.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/entities/report.dart';
import 'package:chatpot_app/components/report_type_selector.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/models/app_state.dart';

class ReportScene extends StatefulWidget {

  final String targetToken;
  final String roomToken;

  ReportScene({
    @required this.targetToken,
    @required this.roomToken
  });

  @override
  State createState() =>
    _ReportSceneState(
      targetToken: targetToken,
      roomToken: roomToken
    );
}

class _ReportSceneState extends State<ReportScene> {

  String _roomToken;
  String _targetToken;
  MemberPublic _targetMember;
  bool _loading;

  ReportType _reportType;
  String _comment;

  _ReportSceneState({
    @required String targetToken,
    @required String roomToken
  }) {
    _targetToken = targetToken;
    _roomToken = roomToken;
    _loading = false;    
    _reportType = null;
    _comment = '';
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
    if (_reportType == null) {
      await showSimpleAlert(context, locales().reportScene.reportTypeSelectionRequired);
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      final state = ScopedModel.of<AppState>(context);
      await reportApi().requestReport(
        memberToken: state.member.token,
        targetToken: _targetToken,
        roomToken: _roomToken,
        reportType: _reportType,
        comment: _comment
      );
      await showSimpleAlert(context, locales().reportScene.reportCompleted,
        title: locales().successTitle
      );
      Navigator.of(context).pop();
    } catch (err) {
      if (err is ApiFailureError) {
        await showSimpleAlert(context, locales().error.messageFromErrorCode(err.code));
        return;
      } else {
        throw err;
      }
    } finally {
      if (this.mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: styles().mainBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: styles().navigationBarBackground,
        previousPageTitle: locales().reportScene.prevButtonLabel,
        actionsForegroundColor: styles().link,
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
                      color: styles().primaryFontColor,
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
                      color: styles().primaryFontColor,
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
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: _buildCommentField(context,
                    callback: (String inputed) => _comment = inputed
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
                    border: Border.all(color: styles().primaryFontColor),
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
                  color: styles().primaryFontColor,
                  fontSize: 17
                )
              ),
              Text(member.regionName,
                style: TextStyle(
                  color: styles().secondaryFontColor,
                  fontSize: 16
                )
              )
            ]
          )
        )
      ]
    );

typedef TextChangedCallback (String inputed);

Widget _buildCommentField(BuildContext context, {
  @required TextChangedCallback callback
}) => CupertinoTextField(
  prefix: Icon(
    MdiIcons.text,
    color: styles().editTextHint,
    size: 28.0
  ),
  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
  placeholder: locales().reportScene.commentFieldPlacholder,
  placeholderStyle: TextStyle(
    color: styles().editTextHint
  ),
  decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 0.0,
        color: styles().secondaryFontColor
      )
    )
  ),
  onChanged: callback,
  style: TextStyle(
    color: styles().editTextFont
  )
);

Widget _buildReportButton(BuildContext context, {
  @required bool loading,
  @required VoidCallback callback
}) {
  return CupertinoButton(
    child: Text(locales().reportScene.reportButtonLabel,
      style: TextStyle(
        color: styles().link
      )
    ),
    onPressed: loading == true ? null : callback
  );
}