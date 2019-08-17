import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/styles.dart';

void showWelcomeOobeDialog(BuildContext context) async {
  await showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => _buildDialog(context)
  );
}

Widget _buildDialog(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(left: 40, right: 40, top: 100, bottom: 100),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: CupertinoColors.white
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(locales().welcomeOobeDialog.page1Title,
          style: TextStyle(
            fontSize: 19,
            color: styles().primaryFontColor
          )
        ),
        Image(
          image: styles().logoImageOnly,
          width: 140,
          height: 140,
        )
      ]
    )
  );
}