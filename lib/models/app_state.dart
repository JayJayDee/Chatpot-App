import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/entities/member.dart';

class AppState extends Model {
  Member _member;
  bool _loading;

  AppState() {
    _member = null;
  }

  Member get member {
    return _member;
  }

  bool get loading {
    return _loading;
  }
}