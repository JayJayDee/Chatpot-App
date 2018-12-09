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
  bool _loginToolsShow;
  Auth _auth;
  Member _member;

  MemberModel() {
    _loading = false;
    _loginToolsShow = false;
  }

  bool get loading => _loading;
  bool get loginToolsShow => _loginToolsShow;

  Auth get auth => _auth;
  Member get member => _member;

  Future initialize() async {
    _loading = true;
    notifyListeners();

    Future delay = new Future.delayed(const Duration(seconds: 5), () {});
    await delay;

    Auth localAuth = await fetchAuthFromLocal();
    if (localAuth.authToken == null) {
      _loginToolsShow = true;
      _loading = false;
      notifyListeners();
      return;
    }
  }
}