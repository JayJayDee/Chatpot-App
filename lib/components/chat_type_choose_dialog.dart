import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

enum SelectedChatType {
  PUBLIC, ROULETTE
}

Future<SelectedChatType> showChatTypeChooseDialog(BuildContext context) async {
  return await showCupertinoDialog<SelectedChatType>(
    context: context,
    builder: (BuildContext context) =>
      CupertinoAlertDialog(
        title: Text(locales().home.newChatChooserTitle),
        actions: [
          _buildPublicChatMenuItem(
            callback: () => Navigator.pop(context, SelectedChatType.PUBLIC)
          ),
          _buildChatRouletteMenuItem(
            callback: () => Navigator.pop(context, SelectedChatType.ROULETTE)
          ),
          CupertinoDialogAction(
            child: Text(locales().home.cancel),
            onPressed: () => Navigator.pop(context, null),
            isDestructiveAction: true
          )
        ]
      )
  );
}

Widget _buildChatRouletteMenuItem({
  @required VoidCallback callback
}) =>
  CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: () => callback(),
    child: Container(
      margin: EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Icon(MdiIcons.shuffleVariant,
              color: styles().popupPrimaryFontColor,
              size: 28,
            )
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locales().home.ranchatTitle,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: styles().popupPrimaryFontColor,
                    fontSize: 17
                  )
                ),
                Text(locales().home.ranchatDesc,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: styles().popupSecondaryFontColor,
                    fontSize: 15
                  )
                ),
              ]
            )
          )
        ]
      )
    )
  );

Widget _buildPublicChatMenuItem({
  @required VoidCallback callback
}) =>
  CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: () => callback(),
    child: Container(
      margin: EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Icon(MdiIcons.chartBubble,
              color: styles().popupPrimaryFontColor,
              size: 28,
            )
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locales().home.publicTitle,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: styles().popupPrimaryFontColor,
                    fontSize: 17
                  )
                ),
                Text(locales().home.publicDesc,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: styles().popupSecondaryFontColor,
                    fontSize: 15
                  )
                )
              ]
            )
          )
        ]
      )
    )
  );