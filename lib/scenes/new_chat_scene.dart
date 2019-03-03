import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/styles.dart';

class NewChatScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
                      fontSize: 17
                    )
                  )
                ),
                _buildRoomTitleField(),
                _buildMaxAttendeefield(),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: CupertinoButton(
                    child: Text('Create a new chat'),
                    color: CupertinoColors.activeBlue,
                    onPressed: () {

                    }
                  ),
                )
              ],
            ),
            Positioned(
              child: CupertinoActivityIndicator()
            )
          ]
        )
      )
    );
  }  
}

Widget _buildRoomTitleField() {
  return Container(
    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
    child: CupertinoTextField(
      prefix: Icon(
        CupertinoIcons.book,
        color: CupertinoColors.lightBackgroundGray,
        size: 28.0
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
      placeholder: 'Room title here',
      keyboardType: TextInputType.emailAddress,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
      )
    )
  );
}

Widget _buildMaxAttendeefield() {
  return Container(
    padding: EdgeInsets.only(left: 10, top: 10, right: 10),
    child: CupertinoTextField(
      prefix: Icon(
        CupertinoIcons.book,
        color: CupertinoColors.lightBackgroundGray,
        size: 28.0
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
      placeholder: 'number of max attendee (2 ~ 10)',
      keyboardType: TextInputType.number,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.0, color: CupertinoColors.inactiveGray))
      )
    )
  );
}