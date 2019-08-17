import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';
import 'package:chatpot_app/models/app_state.dart';

void showWelcomeOobeDialog(BuildContext context) async {
  await showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => _buildDialog(context)
  );
}

Widget _buildDialog(BuildContext context) {
  final state = ScopedModel.of<AppState>(context);

  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(left: 40, right: 40, top: 100, bottom: 100),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: styles().mainBackground
    ),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _buildPage1(context),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text(locales().welcomeOobeDialog.nextButton,
              style: TextStyle(
                fontSize: 17
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }
          )
        )
      ]
    )
  );
}

Widget _buildPage1(BuildContext context) {
  final state = ScopedModel.of<AppState>(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(top: 20),
        child: Text(locales().welcomeOobeDialog.page1Title,
          style: TextStyle(
            fontSize: 19,
            color: styles().primaryFontColor
          )
        )
      ),
      Container(
        margin: EdgeInsets.only(top: 25),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Text(locales().welcomeOobeDialog.page1ItsYou,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: styles().primaryFontColor,
            fontSize: 17
          )
        )
      ),
      Container(
        margin: EdgeInsets.only(top: 10),
        width: 140,
        height: 140,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(70),
          child: CachedNetworkImage(
            imageUrl: state.member.avatar.thumb,
            placeholder: (context, url) => CupertinoActivityIndicator(),
          ),
        )
      ),
      Container(
        margin: EdgeInsets.only(top: 25),
        child: Text(locales().welcomeOobeDialog.page1ItsYouPrefix,
          style: TextStyle(
            color: styles().primaryFontColor,
            fontSize: 17
          )
        )
      ),
      Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(locales().getNick(state.member.nick),
          style: TextStyle(
            color: styles().primaryFontColor,
            fontSize: 17,
            fontWeight: FontWeight.bold
          )
        )
      ),
      locales().welcomeOobeDialog.page1ItsYouPostfix == '' ?
        Container() :
        Container(
          child: Text(locales().welcomeOobeDialog.page1ItsYouPostfix,
            style: TextStyle(
              color: styles().primaryFontColor,
              fontSize: 17
            )
          ) 
        )
    ]
  );
}