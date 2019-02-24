class Member {
  Nick nick;
  String region;
  String regionName;
  String language;
  String token;
  Gender gender;
  Avatar avatar;
  AuthType authType;

  Member();

  factory Member.fromJson(Map<String, dynamic> map) {
    Member member = Member();
    member.nick = Nick.fromJson(map['nick']);
    member.region = map['region'];
    member.language = map['language'];
    member.token = map['token'];
    member.avatar = Avatar.fromJson(map['avatar']);

    if (map['gender'] == 'F') member.gender = Gender.F;
    else if (map['gender'] == 'M') member.gender = Gender.M;

    if (map['auth_type'] == 'SIMPLE') member.authType = AuthType.SIMPLE;
    else if (map['auth_type'] == 'EMAIL') member.authType = AuthType.EMAIL;

    return member;
  }
  
  @override
  toString() => "${nick.ko}:$token";
}

class Nick {
  String ko;
  String ja;
  String en;

  Nick();

  factory Nick.fromJson(Map<String, dynamic> map) {
    Nick nick = Nick();
    nick.ko = map['ko'];
    nick.en = map['en'];
    nick.ja = map['ja'];
    return nick;
  }

  @override
  toString() => "$ko";
}

enum Gender {
  M, F
}

enum AuthType {
  SIMPLE, EMAIL
}

class Avatar {
  String image;
  String thumb;

  Avatar();

  factory Avatar.fromJson(Map<String, dynamic> map) {
    Avatar avatar = Avatar();
    avatar.image = map['profile_image'];
    avatar.thumb = map['profile_thumb'];
    return avatar;
  }
}