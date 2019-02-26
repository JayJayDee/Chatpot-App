import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/factory.dart';

delaySec(int sec) => Future.delayed(Duration(milliseconds: sec * 1000));

enum AppInitState {
  LOGGED_IN, NEWCOMER
}

class AppState extends Model {
  Member _member;
  bool _loading;

  AppState() {
    _member = null;
    _loading = true;
  }

  Member get member => _member;
  bool get loading => _loading;

  Future<AppInitState> tryAutoLogin() async {
    _loading = true;
    notifyListeners();
    await delaySec(2);

    var accesor = authAccessor();
    var token = await accesor.getToken();
    if (token == null) {
      _loading = false;
      notifyListeners();
      return AppInitState.NEWCOMER;
    }

    var member = await memberApi().fetchMy(token);
    _member = member;
    
    _loading = false;
    notifyListeners();
    return AppInitState.LOGGED_IN;
  }

  Future<void> simpleSignup({
    @required String gender,
    @required String region,
    @required String language
  }) async {
    _loading = true;
    notifyListeners();

    var joinResp = await authApi().requestSimpleJoin(
      gender: gender,
      region: region,
      language: language
    );

    var authResp = await authApi().requestAuth(
      loginId: joinResp.token,
      password: joinResp.passphrase
    );

    await authAccessor().setToken(joinResp.token);
    await authAccessor().setPassword(joinResp.passphrase);
    await authAccessor().setSessionKey(authResp.sessionKey);

    var member = await memberApi().fetchMy(joinResp.token);
    print(member);
    _member = member;
    _loading = false;
    notifyListeners();
  }

  Future<void> signout() async {
    _loading = true;
    notifyListeners();

    authAccessor().setToken(null);
    authAccessor().setPassword(null);
    authAccessor().setSessionKey(null);

    await delaySec(1);
    _member = null;
    _loading = false;
    notifyListeners();
  }
}