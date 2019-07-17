import 'package:chatpot_app/apis/api_entities.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';
import 'package:chatpot_app/apis/api_errors.dart';

class ProfileEditScene extends StatefulWidget {
  @override
  State createState() => _ProfileEditSceneState();
}

class _ProfileEditSceneState extends State<ProfileEditScene> {

  bool _loading;
  Gacha _status;

  _ProfileEditSceneState() {
    _loading = false;
  }

  @override
  void initState() {
    super.initState();
    _loadGachaStatus();
  }

  void _loadGachaStatus() async {
    setState(() => _loading = true);
    final state = ScopedModel.of<AppState>(context);

    try {
      Gacha status = await gachaApi().requestGachaStatus(
        memberToken: state.member.token
      );
      setState(() {
        _status = status;
      });
    } catch (err) {
      if (err is ApiFailureError) {
        await showSimpleAlert(context,
          locales().error.messageFromErrorCode(err.code));
      } else {
        throw err;
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  void _onNickGachaClicked() async {
    var isOk = await _showGachaConfirm(context, GachaType.NICK);
    if (isOk == false) return;

    setState(() => _loading = true);

    final state = ScopedModel.of<AppState>(context);

    var resp;
    try {
      resp = await gachaApi().requestNickGacha(memberToken: state.member.token);
    } catch (err) {
      if (err is ApiFailureError) {
        if (err.code == 'INSUFFICIENT_NUM_GACHA') {
          await showSimpleAlert(context,
            locales().profileEditScene.noDiceError);
          return;
        } else {
          await showSimpleAlert(context,
            locales().error.messageFromErrorCode(err.code));
          return;
        }
      } else {
        throw err;
      }
    } finally {
      setState(() => _loading = false);
    }

    await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) =>
        CupertinoAlertDialog(
          title: Text(locales().profileEditScene.resultTitle),
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(locales().getNick(resp.prevNick),
                  style: TextStyle(
                    color: styles().primaryFontColor,
                    fontSize: 17
                  )
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Icon(MdiIcons.arrowDown,
                  color: styles().primaryFontColor,
                  size: 30
                )
              ),
              Container(
                child: Text(locales().getNick(resp.newNick),
                  style: TextStyle(
                    color: styles().primaryFontColor,
                    fontSize: 17
                  )
                )
              )
            ]
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(locales().profileEditScene.okTitle),
              onPressed: () => Navigator.pop(context, true)
            ),
          ]
        )
    );
    _loadGachaStatus();
    state.refreshProfile();
  }

  void _onAvatarGachaClicked() async {
    var isOk = await _showGachaConfirm(context, GachaType.AVATAR);
    if (isOk == false) return;
    
    setState(() => _loading = true);

    final state = ScopedModel.of<AppState>(context);

    AvatarGachaResp resp;
    try {
      resp = await gachaApi().requestAvatarGacha(memberToken: state.member.token);
    } catch (err) {
      if (err is ApiFailureError) {
        if (err.code == 'INSUFFICIENT_NUM_GACHA') {
          await showSimpleAlert(context,
            locales().profileEditScene.noDiceError);
          return;
        } else {
          await showSimpleAlert(context,
            locales().error.messageFromErrorCode(err.code));
          return;
        }
      } else {
        throw err;
      }
    } finally {
      setState(() => _loading = false);
    }

    await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) =>
        CupertinoAlertDialog(
          title: Text(locales().profileEditScene.resultTitle),
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: _profilePhoto(context, resp.prevAvatar)
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Icon(MdiIcons.arrowDown,
                  color: styles().primaryFontColor,
                  size: 30
                )
              ),
              Container(
                child: _profilePhoto(context, resp.newAvatar)
              )
            ]
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(locales().profileEditScene.okTitle),
              onPressed: () => Navigator.pop(context, true)
            ),
          ]
        )
    );
    _loadGachaStatus();
    state.refreshProfile();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: styles().mainBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: styles().navigationBarBackground,
        previousPageTitle: locales().setting.title,
        actionsForegroundColor: styles().link,
        middle: Text(locales().profileEditScene.title,
          style: TextStyle(
            color: styles().primaryFontColor
          )
        ),
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(locales().profileEditScene.description,
                    style: TextStyle(
                      color: styles().primaryFontColor,
                      fontSize: 16
                    )
                  )
                ),
                _buildAvatarGachaArea(context,
                  loading: _loading,
                  gacha: _status,
                  rollCallback: () => _onAvatarGachaClicked()
                ),
                _buildNickGachaArea(context,
                  loading: _loading,
                  gacha: _status,
                  rollCallback: () => _onNickGachaClicked()
                )
              ]
            ),
            Positioned(
              child: _buildProgress(context, loading: _loading)
            )
          ]
        )
      )
    );
  }
}

Widget _buildProgress(BuildContext context, {
  @required bool loading
}) =>
  loading == true ? CupertinoActivityIndicator() : Container();

Widget _buildAvatarGachaArea(BuildContext context, {
  @required bool loading,
  @required Gacha gacha,
  @required VoidCallback rollCallback
}) =>
  Container(
    margin: EdgeInsets.only(left: 10, right: 10, top: 20),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: styles().profileCardBackground
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Icon(MdiIcons.faceProfile,
              size: 50,
              color: styles().primaryFontColor
            ),
            Text(locales().profileEditScene.avatar,
              style: TextStyle(
                color: styles().primaryFontColor,
                fontSize: 16
              )
            )
          ]
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
              gacha == null ? locales().profileEditScene.remainCount('...') :
                locales().profileEditScene.remainCount(gacha.remainAvatarGacha),
            style: TextStyle(
              color: styles().secondaryFontColor,
              fontSize: 17
            )
          )
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(MdiIcons.diceMultiple,
            size: 50,
            color: styles().link,
          ),
          onPressed: loading == true ? null : rollCallback
        )
      ]
    )
  );

Widget _buildNickGachaArea(BuildContext context, {
  @required bool loading,
  @required Gacha gacha,
  @required VoidCallback rollCallback
}) =>
  Container(
    margin: EdgeInsets.only(left: 10, right: 10, top: 20),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: styles().profileCardBackground
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Icon(MdiIcons.tagFaces,
              size: 50,
              color: styles().primaryFontColor
            ),
            Text(locales().profileEditScene.nick,
              style: TextStyle(
                color: styles().primaryFontColor,
                fontSize: 16
              )
            )
          ]
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(gacha == null ? locales().profileEditScene.remainCount('...') :
              locales().profileEditScene.remainCount(gacha.remainNickGacha),
            style: TextStyle(
              color: styles().secondaryFontColor,
              fontSize: 17
            )
          )
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(MdiIcons.diceMultiple,
            size: 50,
            color: styles().link,
          ),
          onPressed: loading == true ? null : rollCallback
        )
      ]
    )
  );

enum GachaType {
  NICK, AVATAR
}

Future<bool> _showGachaConfirm(BuildContext context, GachaType type) async {
  return await showCupertinoDialog<bool>(
    context: context,
    builder: (BuildContext context) =>
      CupertinoAlertDialog(
        title: Text(locales().profileEditScene.gachaConfirmTitle),
        content: Text(
          type == GachaType.AVATAR ? locales().profileEditScene.gachaAvatarDesc :
            locales().profileEditScene.gachaNickDesc
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(locales().profileEditScene.okTitle),
            onPressed: () => Navigator.pop(context, true)
          ),
          CupertinoDialogAction(
            child: Text(locales().profileEditScene.cancelTitle),
            onPressed: () => Navigator.pop(context, false),
            isDestructiveAction: true
          )
        ]
      )
  );
}

Widget _profilePhoto(BuildContext context, Avatar avatar) {
  final state = ScopedModel.of<AppState>(context);
  return Container(
    width: 60,
    height: 60,
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CachedNetworkImage(
            imageUrl: avatar.thumb,
            placeholder: (context, url) => CupertinoActivityIndicator(),
          )
        ),
        Container(
          width: 20,
          height: 10,
          decoration: BoxDecoration(
            border: Border.all(color: styles().primaryFontColor),
            image: DecorationImage(
              image: locales().getFlagImage(state.member.region),
              fit: BoxFit.cover
            )
          )
        )
      ]
    )
  );
}