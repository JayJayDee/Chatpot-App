import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
import 'package:chatpot_app/entities/member.dart';

Future<void> showMemberDetailSheet(BuildContext context, {
  @required String memberToken 
}) async {
  await showCupertinoModalPopup<bool>(
    context: context,
    builder: (BuildContext context) =>
      CupertinoActionSheet(
        message: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _MemberDetailSheet(memberToken: memberToken)
          ]
        ),
      )
  );
}

class _MemberDetailSheet extends StatefulWidget {

  final String memberToken;

  _MemberDetailSheet({
    this.memberToken
  });

  @override
  State createState({
    final memberToken
  }) => _MemberDetailSheetState(memberToken: memberToken);
}

class _MemberDetailSheetState extends State<_MemberDetailSheet> {

  bool _loading;
  String _memberToken;
  MemberPublic _member;

  _MemberDetailSheetState({
    @required String memberToken
  }) {
    _memberToken = memberToken;
    _loading = false;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(); // TODO: implement member-detail popup_scene.
  }
}