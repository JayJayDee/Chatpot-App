import 'package:scoped_model/scoped_model.dart';
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