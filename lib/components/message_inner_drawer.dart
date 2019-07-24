import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/member.dart';

typedef LoadingChangeCallback (bool loading);
typedef MemberSelectCallback (String memberToken);

@immutable
class MessageInnerDrawer extends StatefulWidget {

  final MyRoom room;
  final MemberSelectCallback memberSelectCallback;
  final VoidCallback roomLeaveCallback;
  final MemberInnerDrawerController controller;

  MessageInnerDrawer({
    @required this.room,
    @required this.memberSelectCallback,
    @required this.roomLeaveCallback,
    @required this.controller
  });

  @override
  State createState() => _MessageInnerDrawerState(
    room: room,
    roomLeaveCallback: roomLeaveCallback,
    memberSelectCallback: memberSelectCallback,
    controller: controller
  );
}

class MemberInnerDrawerController {
  VoidCallback _changeCallback;

  MemberInnerDrawerController();

  void notifyMemberChanged() {
    if (_changeCallback != null) {
      _changeCallback();
    }
  }

  void setChangeCallback(VoidCallback callback) {
    _changeCallback = callback;
  }
}

class _MessageInnerDrawerState extends State<MessageInnerDrawer> {

  final MyRoom room;
  final MemberSelectCallback memberSelectCallback;
  final VoidCallback roomLeaveCallback;
  final MemberInnerDrawerController controller;

  RoomDetail _roomDetail;
  bool _loading;

  _MessageInnerDrawerState({
    @required this.room,
    @required this.memberSelectCallback,
    @required this.roomLeaveCallback,
    @required this.controller
  }) {
    controller.setChangeCallback(() => _loadRoomDetails());
    _loading = false;
  }

  @override
  void initState() {
    super.initState();
    _loadRoomDetails();
  }

  void _loadRoomDetails() async {
    setState(() => _loading = true);
    try {
      var roomDetail = await roomApi().requestRoomDetail(
        roomToken: room.roomToken
      );
      setState(() => _roomDetail = roomDetail);
    } catch (err) {
      if (err is ApiFailureError) {
        await showSimpleAlert(context, locales().error.messageFromErrorCode(err.code));
      } else {
        throw err;
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 25),
        child: _buildProfileArea(context)
      ),
      _buildLine(),
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(bottom: 5, top: 5),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(locales().msgscene.leave,
            style: TextStyle(
              color: styles().link
            ),
          ),
          onPressed: () {
            roomLeaveCallback();
          }
        ),
      ),
      _buildLine(),
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(bottom: 5, top: 25),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Text(locales().msgscene.members(_roomDetail),
          style: TextStyle(
            color: styles().primaryFontColor,
            fontSize: 15,
            fontWeight: FontWeight.bold
          )
        )
      )
    ];

    widgets.addAll(_buildMembersRow(
      memberSelectCallback: memberSelectCallback,
      roomDetail: _roomDetail
    ));

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: styles().innerDrawerBackground,
          child: SafeArea(
            child: ListView(children: widgets)          
          )
        ),
        Positioned(
          child: _buildProgress(loading: _loading)
        )
      ]
    );
  }
}

Widget _buildLine() =>
  Container(
    margin: EdgeInsets.only(left: 10, right: 10),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 0.5, color: styles().secondaryFontColor)
      )
    )
  );

List<Widget> _buildMembersRow({
  @required MemberSelectCallback memberSelectCallback,
  @required RoomDetail roomDetail
}) {
  if (roomDetail == null) return List();
  return roomDetail.members.map((m) => 
    Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 7),
              child: _buildAvatarArea(m, 50)
            ),
            Expanded(
              child: Text(locales().getNick(m.nick),
                style: TextStyle(
                  color: styles().primaryFontColor,
                  fontSize: 15
                ),
              )
            )
          ]
        ),
        onPressed: () => memberSelectCallback(m.token)
      )
    )
  ).toList();
}

Widget _buildProgress({
  @required bool loading
}) =>
  loading == true ? CupertinoActivityIndicator() : Container();

Widget _buildProfileArea(BuildContext context) {
  final state = ScopedModel.of<AppState>(context, rebuildOnChange: true);

  return Container(
    child: Column(
      children: [
        Container(
          child: _buildAvatarArea(state.member, 100)
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(locales().getNick(state.member.nick),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: styles().primaryFontColor
            )
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(state.member.regionName,
            style: TextStyle(
              fontSize: 15,
              color: styles().secondaryFontColor
            )
          ),
        ),
      ]
    )  
  );
}

Widget _buildAvatarArea(Member member, double size) {
  return Container(
    width: size,
    height: size,
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: CachedNetworkImage(
            imageUrl: member.avatar.thumb,
            placeholder: (context, url) => CupertinoActivityIndicator(),
            width: size,
            height: size
          )
        ),
        Positioned(
          child: Container(
            width: size / 2.7,
            height: (size / 2.7) / 2,
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
  );
}