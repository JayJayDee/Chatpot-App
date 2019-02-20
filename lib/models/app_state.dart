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

    _loading = false;
    notifyListeners();
    return AppInitState.LOGGED_IN;
  }

  Future<void> simpleSignup() async {
    _loading = true;
    notifyListeners();
  }
}