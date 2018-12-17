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
  static MemberModel _inst;

  static MemberModel getInstance() {
    if (_inst == null) {
      _inst = new MemberModel();
    }
    return _inst;
  }

  MemberModel() {
    _loading = false;
    _loginToolsShow = false;
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

    _auth = localAuth;
    // TODO: to be replaced with real-api-call
    Member member = Member();
    Nick nick = Nick();
    nick.en = 'Dirty Toe';
    nick.ko = '더러운 발가락';
    nick.ja = 'JA_DIRTY_TOE';
    member.nick = nick;
    member.region = 'KR';
    _member = member;
    
    return AuthStatus.AuthCompleted;
  }

  Future<void> doSimpleLogin() async {
    _loading = true;
    _loginToolsShow = false;

    // TODO: to be removed
    Future delay = new Future.delayed(const Duration(seconds: 3), () {});
    await delay;

    // TODO: to be replaced with real-api call
    Auth auth = Auth();
    auth.authToken = 'test-auth-token';

    await storeAuthToLocal(auth);

    // TODO: to be replaced with real-api-call
    Member member = Member();
    Nick nick = Nick();
    nick.en = 'Dirty Toe';
    nick.ko = '더러운 발가락';
    nick.ja = 'JA_DIRTY_TOE';
    member.nick = nick;
    member.region = 'KR';

    _auth = auth;
    _member = member;
    _loading = false;
    _loginToolsShow = false;
  }
}