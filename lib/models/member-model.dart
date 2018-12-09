import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/utils/auth-util.dart';

class Member {
  String nick;
  String region;
}

class Auth {
  String authToken;
}

class MemberModel extends Model {
  bool _loading;
  Auth _auth;
  Member _member;

  MemberModel() {
    _loading = false;
  }

  bool get loading => _loading;
  Auth get auth => _auth;
  Member get member => _member;

  Future authenticate() async {
    _loading = true;
    notifyListeners();

    Auth localAuth = await fetchAuthFromLocal();
    if (localAuth.authToken == null) {
      print('auth-token null');
    }
  }

  static MemberModel of(BuildContext context) {
    return ScopedModel.of<MemberModel>(context);
  }
}