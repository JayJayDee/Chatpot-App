import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';

Future<void> showSimpleAlert(BuildContext context, String msg, {
  String title
}) async {
  String titleReal = title;
  if (titleReal == null) {
    titleReal = locales().errorAlertDefaultTitle;
  }

  await showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) =>
      CupertinoAlertDialog(
        title: Text(titleReal),
        content: Text(msg),
        actions: [
          CupertinoDialogAction(
            child: Text(locales().okButtonLabel),
            onPressed: () => Navigator.pop(context)
          )
        ]
      )
  );
}