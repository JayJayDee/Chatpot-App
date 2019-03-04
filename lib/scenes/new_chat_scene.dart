import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/models/app_state.dart';

String _inputedRoomTitle = '';
String _inputedMaxAttendee = '';

class NewChatScene extends StatelessWidget {

  void _onClickNewChat(BuildContext context) async {
    final model = ScopedModel.of<AppState>(context);
    
    if (_inputedRoomTitle.trim().length == 0) {
      Toast.show('Room title required', context, duration: 2);
      return;
    }
    if (_inputedMaxAttendee.trim().length == 0) {
      Toast.show('Max attendee required', context, duration: 2);
      return;
    }

    var parsed = int.parse(_inputedMaxAttendee);
    String newRoomToken = await model.createNewRoom(
      roomTitle: _inputedRoomTitle,
      maxAttendee: parsed
    );
    Navigator.of(context).pop(newRoomToken);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.mainBackground,
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Back',
        middle: Text('New chat'),
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
                  child: Text('Creates a new chat.',
                    style: TextStyle(
                      color: Styles.primaryFontColor,
                      fontSize: 15
                    )
                  )
                ),
                _buildRoomTitleField((String value) => _inputedRoomTitle = value),
                _buildMaxAttendeefield((String value) => _inputedMaxAttendee = value),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 10, right: 10),
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
        CupertinoIcons.book,
        color: CupertinoColors.lightBackgroundGray,
        size: 28.0
      ),
      onChanged: valueChanged,
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
      placeholder: 'Room title here',
      keyboardType: TextInputType.emailAddress,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
      )
    )
  );
}

Widget _buildMaxAttendeefield(ValueChanged<String> valueChanged) {
  return Container(
    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
    child: CupertinoTextField(
      prefix: Icon(
        CupertinoIcons.book,
        color: CupertinoColors.lightBackgroundGray,
        size: 28.0
      ),
      onChanged: valueChanged,
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
      placeholder: 'number of max attendee (2 ~ 10)',
      keyboardType: TextInputType.number,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
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
    child: Text('Create a new chat'),
    color: CupertinoColors.activeBlue,
    onPressed: conditionalCallback
  );
}