import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/utils/auth-util.dart';

class MemberModel extends Model {

  void initialize() async {
    Auth auth = await fetchAuthFromLocal();
    if (auth == null) {

    }
  }

  void authPrevious() async {
  }
}