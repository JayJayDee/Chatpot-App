import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/models/member-model.dart';

class MyNickView extends StatefulWidget {
  @override
  _MyNickState createState() => _MyNickState(new MemberModel());
}

class _MyNickState extends State<MyNickView> {
  MemberModel _model;

  _MyNickState(MemberModel model) {
    _model = model;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MemberModel>(
      model: _model,
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Text(_model.member.nick.ko),
      )
    );
  }
}