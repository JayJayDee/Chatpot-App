import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/utils/auth-util.dart';

enum AutoLoginResult {
  FirstTime, Completed
}

class MemberModel extends Model {
  
  bool _isLoading = false;

  Future<AutoLoginResult> tryAutoLogin(Locale locale) async {
    _isLoading = true;
    notifyListeners();

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
}