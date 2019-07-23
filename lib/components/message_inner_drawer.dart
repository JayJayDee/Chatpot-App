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
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: styles().innerDrawerBackground,
          child: SafeArea(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 15),
                  child: _buildProfileArea(context)
                ),
                Container(
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
                )
              ]
            )          
          )
        ),
        Positioned(
          child: _buildProgress(loading: _loading)
        )
      ]
    );
  }
}

Widget _buildHeader(String text) {
  return Container(
    padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
    color: styles().listRowHeaderBackground,
    child: Text(text,
      style: TextStyle(
        color: styles().primaryFontColor,
        fontSize: 15
      )
    )
  );
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
          child: _buildAvatarArea(state.member)
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

Widget _buildAvatarArea(Member member) {
  return Container(
    width: 100,
    height: 100,
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: CachedNetworkImage(
            imageUrl: member.avatar.thumb,
            placeholder: (context, url) => CupertinoActivityIndicator(),
            width: 100,
            height: 100
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
  );
}