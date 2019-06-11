import 'dart:async';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/components/simple_alert_dialog.dart';

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
  State createState() =>
    _MemberDetailSheetState(memberToken: this.memberToken);
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

  Future<void> _loadMemberInfo(String token) async {
    setState(() {
      _loading = true;
    });

    try {
      MemberPublic fetched = await memberApi().requestMemberPublic(memberToken: token);
      if (this.mounted == true) {
        setState(() {
          _member = fetched;
          _loading = false;
        });
      }
    } catch (err) {
      if (this.mounted == true) {
        setState(() {
          _loading = false;
        });
      }
      if (err is ApiFailureError) {
        await showSimpleAlert(context, locales().error.messageFromErrorCode(err.code));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    this._loadMemberInfo(_memberToken);
  }
  
  @override
  Widget build(BuildContext context) {
    if (this._loading == true) {
      return Center(
        child: CupertinoActivityIndicator()
      );
    }
    return Container(
      // TODO: member profile to be implemented.
    );
  }
}