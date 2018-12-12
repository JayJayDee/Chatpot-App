import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/utils/auth-util.dart';

class Nick {
  String en;
  String ko;
  String ja;
}

class Member {
  Nick nick;
  String region;
}

class Auth {
  String authToken;
}

enum AuthStatus {
  AuthCompleted,
  LoginRequired
}

class MemberModel extends Model {
  bool _loading;
  bool _loginToolsShow;
  Auth _auth;
  Member _member;

  MemberModel() {
    _loading = false;
    _loginToolsShow = false;

    _member = Member();
    Nick nick = Nick();
    nick.ko = '냄새나는 배꼽';

    _member.nick = nick;
    _member.region = 'KR';
  }

  bool get loading => _loading;
  bool get loginToolsShow => _loginToolsShow;

  Auth get auth => _auth;
  Member get member => _member;

  Future<AuthStatus> initialize() async {
    _loading = true;
    notifyListeners();

    Future delay = new Future.delayed(const Duration(seconds: 2), () {});
    await delay;

    Auth localAuth = await fetchAuthFromLocal();
    if (localAuth.authToken == null) {
      _loginToolsShow = true;
      _loading = false;
      notifyListeners();
      return AuthStatus.LoginRequired;
    }
    
    delay = new Future.delayed(const Duration(seconds: 3), () {});
    await delay;    
    return AuthStatus.AuthCompleted;
  }
}