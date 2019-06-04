import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:chatpot_app/factory.dart';

Future<void> showSimpleAlert(BuildContext context, {
  @required String msg,
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
        actions: [
          CupertinoDialogAction(
            child: Text(locales().okButtonLabel),
            onPressed: () => Navigator.pop(context)
          )
        ]
      )
  );
}