import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatpot_app/entities/message.dart';
import 'package:chatpot_app/models/app_state.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

enum _RowType {
  NOTIFICATION, MY_MSG, OTHER_MSG
}

@immutable
class MessageRow extends StatelessWidget {

  final Message message;
  final AppState state;

  MessageRow({
    @required this.message,
    @required this.state
  });

  Widget build(BuildContext context) {
    String myToken = state.member.token;
    _RowType type = judgeRowType(message, myToken);

    Widget widget;
    if (type == _RowType.MY_MSG) widget = _MyMessageRow(message: message);
    else if (type == _RowType.OTHER_MSG) widget = _OtherMessageRow(message: message);
    else if (type ==_RowType.NOTIFICATION) widget = _NotificationRow(message: message);
    return Center(
      child: widget
    );
  }

  _RowType judgeRowType(Message msg, String myToken) {
    if (msg.messageType == MessageType.NOTIFICATION) return _RowType.NOTIFICATION;
    else if (msg.from.token == myToken) return _RowType.MY_MSG;
    return _RowType.OTHER_MSG;
  }
}

class _NotificationRow extends StatelessWidget {
  final Message message;

  _NotificationRow({
    this.message
  });

  Widget build(BuildContext context) {
    return Center();
  }
}

class _MyMessageRow extends StatelessWidget {
  final Message message;

  _MyMessageRow({
    this.message
  });

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: CupertinoColors.activeBlue,
                    child: Text(message.getTextContent(),
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.white
                      )
                    )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  child: _receiveTimeIndicator(message.sentTime)
                )
              ]
            )
          )
        ]
      )
    );
  }
}

class _OtherMessageRow extends StatelessWidget {
  final Message message;

  _OtherMessageRow({
    this.message
  });

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: CachedNetworkImage(
                    imageUrl: message.from.avatar.thumb,
                    placeholder: (context, url) => CupertinoActivityIndicator(),
                    width: 50,
                    height: 50
                  )
                ),
                Positioned(
                  child: Container(
                    width: 24,
                    height: 12,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: localeConverter().getFlagImage(message.from.region),
                        fit: BoxFit.cover
                      )
                    )
                  )
                )
              ]
            )
          ),
          Padding(padding: EdgeInsets.only(left: 10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(localeConverter().getNick(message.from.nick),
                  style: TextStyle(
                    fontSize: 13,
                    color: Styles.secondaryFontColor
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Styles.appBackground,
                    child: Text(message.getTextContent(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Styles.primaryFontColor
                      ),
                    )
                  )
                ),
                Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  child: _receiveTimeIndicator(message.sentTime)
                )
              ]
            )
          )
        ],
      ),
    );
  }
}

Widget _receiveTimeIndicator(DateTime dt) {
  return Text(localeConverter().messageReceiveTime(dt),
    style: TextStyle(
      fontSize: 12,
      color: Styles.secondaryFontColor
    )
  );
}