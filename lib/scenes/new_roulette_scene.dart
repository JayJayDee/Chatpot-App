import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/apis/api_entities.dart';

class NewRouletteScene extends StatefulWidget {
  @override
  State createState() => _NewRouletteSceneState();
}

class _NewRouletteSceneState extends State<NewRouletteScene> {

  bool _loading;
  List<RouletteStatus> _statuses;

  _NewRouletteSceneState() {
    _loading = false;
    _statuses = [];
  }

  @override
  void initState() {
    super.initState();
    _requestStatuses();
  }

  void _requestStatuses() async {
    final state = ScopedModel.of<AppState>(context);
    setState(() => _loading = true);

    try {
      _statuses = await roomApi().requestRouletteStatuses(memberToken: state.member.token);
    } catch (err) {
      throw err;
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Container(
        margin: EdgeInsets.all(10),
        child: Text(locales().roulettechat.description,
          style: TextStyle(
            color: styles().primaryFontColor,
            fontSize: 16
          )
        )
      ),
      _statuses.length > 0 ? _buildHeader(title: 'My roulette chats') :
        Container(),
    ];

    widgets.addAll(_buildStatuses(
      loading: _loading,
      statuses: _statuses
    ));

    widgets.addAll([
      _buildHeader(title: 'New chat roulette'),
      _buildNewChatArea(loading: _loading)
    ]);

    return CupertinoPageScaffold(
      backgroundColor: styles().mainBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: styles().navigationBarBackground,
        previousPageTitle: locales().roulettechat.previous,
        actionsForegroundColor: styles().link,
        middle: Text(locales().roulettechat.title,
          style: TextStyle(
            color: styles().primaryFontColor
          )
        ),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              children: widgets
            ),
            Positioned(
              child: _buildProgress(loading: _loading)
            )
          ]
        )
      )
    );
  }
}

Widget _buildProgress({
  @required bool loading
}) =>
  loading == true ? CupertinoActivityIndicator() : Container();

Widget _buildHeader({
  @required String title
}) =>
  Container(
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: styles().listRowHeaderBackground,
      border: Border(
        top: BorderSide(color: styles().listRowDivider, width: 0.3),
        bottom:BorderSide(color: styles().listRowDivider, width: 0.3)
      )
    ),
    child: Text(title,
      style: TextStyle(
        fontSize: 15,
        color: styles().primaryFontColor
      )
    )
  );

Widget _buildNewChatArea({
  @required bool loading
}) =>
  Container(
    margin: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CupertinoButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: styles().profileCardBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  child: Icon(MdiIcons.flagVariant,
                    size: 30,
                    color: styles().primaryFontColor
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text("With\nForeigner",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: styles().primaryFontColor,
                      fontSize: 16
                    )
                  )
                )
              ]
            )
          )
        ),
        CupertinoButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: styles().profileCardBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  child: Icon(MdiIcons.flagVariant,
                    size: 30,
                    color: styles().primaryFontColor
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text("I Don't",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: styles().primaryFontColor,
                      fontSize: 16
                    )
                  )
                )
              ]
            )
          )
        )
      ]
    )
  );

List<Widget> _buildStatuses({
  @required bool loading,
  @required List<RouletteStatus> statuses
}) =>
  statuses.map((s) => _buildStatusWidget(loading: loading, status: s)).toList();

Widget _buildStatusWidget({
  @required bool loading,
  @required RouletteStatus status
}) =>
  Container(
    padding: EdgeInsets.only(left: 12, right: 8, top: 12, bottom: 12),
    child: Row(
      children: [
        Container(
          child: status.matchStatus == RouletteMatchStatus.MATCHED ?
            Icon(MdiIcons.check,
              color: styles().primaryFontColor,
              size: 28,
            ) :
            CircularProgressIndicator(
              strokeWidth: 2.0
            )
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(status.matchStatus == RouletteMatchStatus.MATCHED ? locales().roulettechat.indicatorMatched : locales().roulettechat.indicatorWaiting,
            style: TextStyle(
              color: styles().primaryFontColor,
              fontSize: 17
            )
          )
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 15),
            child: Text('15 minutes ago',
              style: TextStyle(
                color: styles().secondaryFontColor,
                fontSize: 15
              )
            )
          )
        ),
        Container(
          child: CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Icon(MdiIcons.cancel,
              size: 27,
              color: styles().link
            ),
            onPressed: () {}
          )
        )
      ]
    )
  );