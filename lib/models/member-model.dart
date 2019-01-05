import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/utils/auth-util.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/apis/member-api.dart';

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

    Future delay = new Future.delayed(const Duration(seconds: 1), () {});
    await delay;

    Auth localAuth = await fetchAuthFromLocal();
    if (localAuth == null) {
      _loginToolsShow = true;
      _loading = false;
      notifyListeners();
      return AuthStatus.LoginRequired;
    }
    
    _auth = localAuth;
    ResGetMember memberRes = await memberGet(auth, token: _auth.authToken);

    Member member = Member(
      nick: memberRes.nick,
      gender: memberRes.gender,
      region: memberRes.region,
    );
    _member = member;
    return AuthStatus.AuthCompleted;
  }

  Future<void> doSimpleLogin() async {
    _loading = true;
    _loginToolsShow = false;
    notifyListeners();

    Future delay = new Future.delayed(const Duration(seconds: 1), () {});
    await delay;

    const gender = 'M';
    const region = 'KR';
    const language = 'ko';

    ResCreateMember createRes = await memberCreate(
      region: region,
      language: language,
      gender: gender
    );

    await storeAuthToLocal(createRes.token, createRes.passphrase);
    _auth = Auth(authToken: createRes.token, secret: createRes.passphrase);

    Member member = Member(
      nick: createRes.nick,
      gender: gender,
      region: region,
    );
    
    _member = member;
    _loading = false;
    _loginToolsShow = false;
    notifyListeners();
  }
}