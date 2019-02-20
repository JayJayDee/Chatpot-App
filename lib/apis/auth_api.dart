import 'package:meta/meta.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/apis/requester.dart';

class SimpleJoinApiResp {
  Nick nick;
  String token;
  String passphrase;
}

class AuthApi {
  Requester _requester;

  AuthApi({
    @required Requester requester
  }) {
    _requester = requester;
  }

  Future<SimpleJoinApiResp> requestSimpleJoin({
    @required String region,
    @required String language,
    @required String gender
  }) async {
    Map<String, dynamic> resp = await _requester.request(
      url: '/member',
      method: HttpMethod.POST,
      body: {
        'region': region,
        'language': language,
        'gender': gender
      }
    );
    SimpleJoinApiResp ret = SimpleJoinApiResp();
    // TODO: deserialize reponse into entity.
    return null;
  }
}