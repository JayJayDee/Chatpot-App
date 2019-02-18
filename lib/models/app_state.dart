import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/entities/member.dart';

class AppState extends Model {
  Member _member;

  AppState() {
    _member = null;
  }

  Member get member {
    return _member;
  }
}