import 'package:chatpot_app/apis/api_errors.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';

String _inputedRoomTitle = '';
String _inputedMaxAttendee = '';

class NewChatScene extends StatelessWidget {

  void _onClickNewChat(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context);
    
    if (_inputedRoomTitle.trim().length == 0) {
      await showSimpleAlert(context, locales().newchat.roomTitleRequired);
      return;
    }
    if (_inputedMaxAttendee.trim().length == 0) {
      await showSimpleAlert(context, locales().newchat.maximunAttendeeRequired);
      return;
    }

    var parsed; 
    try {
      parsed = int.parse(_inputedMaxAttendee);
    } catch (err) {
      await showSimpleAlert(context, locales().newchat.invalidMaximumAttendees);
      return;
    }

    try {
      String newRoomToken = await model.createNewRoom(
        roomTitle: _inputedRoomTitle,
        maxAttendee: parsed
      );
      Navigator.of(context).pop(newRoomToken);
    } catch (err) {
      if (err is ApiFailureError) {
        await showSimpleAlert(context, locales().error.messageFromErrorCode(err.code));
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: styles().mainBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: locales().chats.title,
        middle: Text(locales().newchat.title),
        transitionBetweenRoutes: true
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Text(locales().newchat.header,
                    style: TextStyle(
                      color: styles().primaryFontColor,
                      fontSize: 16
                    )
                  )
                ),
                _buildRoomTitleField((String value) => _inputedRoomTitle = value),
                _buildMaxAttendeefield((String value) => _inputedMaxAttendee = value),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: _buildNewChatButton(context, () => _onClickNewChat(context))
                )
              ],
            ),
            Positioned(
              child: _buildProgress(context)
            )
          ]
        )
      )
    );
  }  
}

Widget _buildRoomTitleField(ValueChanged<String> valueChanged) {
  return Container(
    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
    child: CupertinoTextField(
      prefix: Icon(
        MdiIcons.pencil,
        color: styles().thirdFontColor,
        size: 28.0
      ),
      onChanged: valueChanged,
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
      placeholder: locales().newchat.placeHolderTitle,
      placeholderStyle: TextStyle(
        color: styles().thirdFontColor
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: styles().inputFieldDevidier
          )
        )
      )
    )
  );
}

Widget _buildMaxAttendeefield(ValueChanged<String> valueChanged) {
  return Container(
    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
    child: CupertinoTextField(
      prefix: Icon(
        MdiIcons.accountGroup,
        color: styles().thirdFontColor,
        size: 28.0
      ),
      onChanged: valueChanged,
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
      placeholder: locales().newchat.placeHolderMaxAttendee,
      placeholderStyle: TextStyle(
        color: styles().thirdFontColor
      ),
      keyboardType: TextInputType.number,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: styles().inputFieldDevidier
          )
        )
      )
    )
  );
}

Widget _buildProgress(BuildContext context) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  if (model.loading == true) return CupertinoActivityIndicator();
  return Center();
}

Widget _buildNewChatButton(BuildContext context, VoidCallback callback) {
  final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);
  VoidCallback conditionalCallback;
  if (model.loading == false) conditionalCallback = callback;
  
  return CupertinoButton(
    child: Text(locales().newchat.buttonCreate,
      style: TextStyle(
        fontSize: 15
      )
    ),
    onPressed: conditionalCallback
  );
}