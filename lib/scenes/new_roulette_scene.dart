import 'dart:async';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:chatpot_app/entities/notification.dart';
import 'package:oktoast/oktoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:chatpot_app/scenes/message_scene.dart';
import 'package:chatpot_app/entities/push.dart';

final tag = 'NEW_ROULETTE_SCENE';

class NewRouletteScene extends StatefulWidget {
  @override
  State createState() => _NewRouletteSceneState();
}

class _NewRouletteSceneState extends State<NewRouletteScene> with WidgetsBindingObserver {

  bool _loading;

  _NewRouletteSceneState() {
    _loading = false;
  }

  @override
  void initState() {
    super.initState();
    _requestStatuses();
    
    print("$tag INIT_STATE");
    pushService().setPushListener(tag, _onPushReceived);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    pushService().unsetPushListener(tag);
    print("$tag DISPOSE");
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var func = () async {
      if (state == AppLifecycleState.resumed) {
        _requestStatuses();

        print("$tag RESUMED");
        pushService().setPushListener(tag, _onPushReceived);

      } else if (state == AppLifecycleState.paused) {
        print("$tag PAUSED");
        pushService().unsetPushListener(tag);
      } else if (state == AppLifecycleState.inactive) {
        print("$tag INACTIVATED");
        pushService().unsetPushListener(tag);
      }
    };
    func();
  }

  void _onPushReceived(Push push) async {
    print("$tag PUSH_RECEIVED");
    print(push);
    final state = ScopedModel.of<AppState>(context);
    if (push.pushType == PushType.NOTIFICATION) {
      PushNotification noti = push.getContent();

      if (noti.notificationType == PushNotificationType.CHAT_ROULLETE_MATCHED) {

        if (this.mounted) {
          showToast(locales().roulettechat.matchedToastMessage,
            duration: Duration(milliseconds: 1000),
            position: ToastPosition(align: Alignment.bottomCenter)
          );
          _requestStatuses();
          state.fetchMyRooms();
        }
      }
    }
  }

  void _requestStatuses() async {
    final state = ScopedModel.of<AppState>(context);
    setState(() => _loading = true);

    try {
      await state.fetchMyRoulettes();
    } catch (err) {
      throw err;
    } finally {
      setState(() => _loading = false);
    }
  }

  void _onNewChatSelect(_RouletteType type) async {
    var result = await _showNewRouletteConfirm(context, type);
    if (result != true) return;

    setState(() => _loading = true);
    final state = ScopedModel.of<AppState>(context);

    try {
      await roomApi().requestNewRoulette(
        memberToken: state.member.token,
        regionType: type == _RouletteType.FOREIGNER ? RegionType.FOREIGNER : RegionType.ALL
      );
    } catch (err) {
      if (err is ApiFailureError) {
        await showSimpleAlert(context, locales().error.messageFromErrorCode(err.code));
        return;
      }
    } finally {
      setState(() => _loading = false);
    }
    _requestStatuses();
  }

  void _onRouletteCancel(RouletteStatus status) async {
    setState(() => _loading = true);
    final state = ScopedModel.of<AppState>(context);

    try {
      await roomApi().requestCancelRoulette(
        memberToken: state.member.token,
        requestId: status.requestId
      );
    } catch (err) {
      if (err is ApiFailureError) {
        await showSimpleAlert(context, locales().error.messageFromErrorCode(err.code));
        return;
      }
    } finally {
      setState(() => _loading = false);
    }
    _requestStatuses();
  }

  void _onGoToChatting(RouletteStatus status) async {
    setState(() => _loading = true);
    final state = ScopedModel.of<AppState>(context);

    try {
      await state.fetchMyRooms();

      var rooms = state.myRooms.where((r) =>
          r.roomToken == status.roomToken).toList();

      if (rooms.length > 0) {
        await Navigator.of(context).push(CupertinoPageRoute<bool>(
          builder: (BuildContext context) => MessageScene(
            room: rooms[0]
          )
        ));
      }
    } finally {
      setState(() {
        if (mounted == true) {
          _loading = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ScopedModel.of<AppState>(context, rebuildOnChange: true);
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
      state.roulettes.length > 0 ? _buildHeader(title: locales().roulettechat.myRouletteChat) :
        Container(),
    ];

    widgets.addAll(_buildStatuses(
      loading: _loading,
      context: context,
      cancelCallback: _onRouletteCancel,
      gotoCallback: _onGoToChatting
    ));

    widgets.addAll([
      _buildHeader(title: locales().roulettechat.newRouletteChat),
      Container(
        margin: EdgeInsets.all(10),
        child: Text(locales().roulettechat.newChatDescription,
          style: TextStyle(
            fontSize: 16,
            color: styles().primaryFontColor
          ),
        )
      ),
      _buildNewChatArea(
        loading: _loading,
        callback: _onNewChatSelect
      )
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

enum _RouletteType {
  FOREIGNER, ALL
}
typedef TypeSelectCallback (_RouletteType type);

Widget _buildNewChatArea({
  @required bool loading,
  @required TypeSelectCallback callback
}) =>
  Container(
    margin: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CupertinoButton(
          padding: EdgeInsets.all(0),
          onPressed: loading == true ? null : () => callback(_RouletteType.FOREIGNER),
          child: Container(
            width: 120,
            height: 120,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: styles().profileCardBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Icon(MdiIcons.earth,
                    size: 35,
                    color: styles().primaryFontColor
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(locales().roulettechat.btnLabelForeigner,
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
          onPressed: loading == true ? null : () => callback(_RouletteType.ALL),
          child: Container(
            width: 120,
            height: 120,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: styles().profileCardBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Icon(Icons.accessibility_new,
                    size: 35,
                    color: styles().primaryFontColor
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(locales().roulettechat.btnLabelAnybody,
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

typedef RouletteSelectCallback (RouletteStatus roulette);

List<Widget> _buildStatuses({
  @required BuildContext context,
  @required bool loading,
  @required RouletteSelectCallback cancelCallback,
  @required RouletteSelectCallback gotoCallback
}) {
  final state = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  return state.roulettes.map((s) => _buildStatusWidget(
    loading: loading,
    status: s,
    cancelCallback: cancelCallback,
    gotoCallback: gotoCallback)).toList();
}

Widget _buildStatusWidget({
  @required bool loading,
  @required RouletteStatus status,
  @required RouletteSelectCallback cancelCallback,
  @required RouletteSelectCallback gotoCallback
}) =>
  Container(
    padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              status.regionType == RegionType.ALL ?
                Icon(Icons.accessibility_new,
                  size: 30,
                  color: styles().secondaryFontColor
                ) :
                Icon(MdiIcons.earth,
                  size: 30,
                  color: styles().secondaryFontColor
                ),

              status.matchStatus == RouletteMatchStatus.MATCHED ?
                Icon(MdiIcons.check,
                  color: styles().primaryFontColor,
                  size: 28,
                ) :
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0
                  )
                )
            ]
          )
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(status.matchStatus == RouletteMatchStatus.MATCHED ?
                      locales().roulettechat.indicatorMatched :
                      locales().roulettechat.indicatorWaiting,
                  style: TextStyle(
                    color: styles().primaryFontColor,
                    fontSize: 17
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 3),
                  child: Text(locales().message.messageReceiveTime(status.regDate),
                    style: TextStyle(
                      color: styles().secondaryFontColor,
                      fontSize: 15
                    )
                  )
                )
              ]
            )
          )
        ),
        Container(
          child: CupertinoButton(
            padding: EdgeInsets.all(0),
            child: 
              status.matchStatus == RouletteMatchStatus.WAITING ?
                Icon(MdiIcons.closeCircle,
                  size: 27,
                  color: styles().secondaryFontColor
                ) :
              Text(locales().roulettechat.enterBtnLabel,
                style: TextStyle(
                  color: styles().link,
                  fontSize: 17
                )
              ),
            onPressed: loading == true ? null : () {
              if (status.matchStatus == RouletteMatchStatus.WAITING) {
                cancelCallback(status);
              } else if (status.matchStatus == RouletteMatchStatus.MATCHED) {
                gotoCallback(status);
              }
            }
          )
        )
      ]
    )
  );

Future<bool> _showNewRouletteConfirm(BuildContext context, _RouletteType type) async {
  return await showCupertinoDialog<bool>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(locales().roulettechat.confirmTitle),
      content: Text(
        type == _RouletteType.ALL ? locales().roulettechat.anybodyConfirm :
        locales().roulettechat.foreignerConfirm),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(locales().okButtonLabel),
          onPressed: () => Navigator.pop(context, true)
        ),
        CupertinoDialogAction(
          child: Text(locales().setting.cancel),
          onPressed: () => Navigator.pop(context, null),
          isDefaultAction: true,
          isDestructiveAction: true,
        )
      ]
    )
  );
}