import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/utils/auth-util.dart';

enum AutoLoginResult {
  FirstTime, Completed
}

MemberModel _inst;

delayLittle(double sec) async =>
  Future.delayed(Duration(milliseconds: (sec * 1000).round()));

class MemberModel extends Model {
  
  bool _isLoading = false;

  bool get loading => _isLoading;

  static MemberModel getInstance() {
    if (_inst == null) _inst = new MemberModel();
    return _inst;
  }

  Future<AutoLoginResult> tryAutoLogin(Locale locale) async {
    _isLoading = true;
    notifyListeners();

    await delayLittle(2);

    Auth auth = await fetchAuthFromLocal();
    if (auth == null) {
      _isLoading = false;
      notifyListeners();
      return AutoLoginResult.FirstTime;
    }

    _isLoading = false;
    notifyListeners();
    return AutoLoginResult.Completed;
  }

  Future<Auth> createSimpleAccount(Locale locale) async {
    _isLoading = true;
    notifyListeners();
    return null;
  }
}