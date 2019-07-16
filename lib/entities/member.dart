class Member {
  Nick nick;
  String region;
  String regionName;
  String language;
  String token;
  Gender gender;
  Avatar avatar;
  AuthType authType;
  String loginId;

  Member();

  factory Member.fromJson(Map<String, dynamic> map) {
    Member member = Member();
    member.nick = Nick.fromJson(map['nick']);
    member.region = map['region'];
    member.regionName = map['region_name'];
    member.language = map['language'];
    member.token = map['token'];
    member.avatar = Avatar.fromJson(map['avatar']);
    member.loginId = map['login_id'];

    if (map['gender'] == 'F') member.gender = Gender.F;
    else if (map['gender'] == 'M') member.gender = Gender.M;
    else member.gender = Gender.NOT_YET;

    if (map['auth_type'] == 'SIMPLE') member.authType = AuthType.SIMPLE;
    else if (map['auth_type'] == 'EMAIL') member.authType = AuthType.EMAIL;

    return member;
  }
  
  @override
  toString() => "${nick.ko}:$token";
}

class MemberPublic {
  String region;
  String regionName;
  String language;
  Gender gender;
  Nick nick;
  Avatar avatar;
  String token;

  MemberPublic();

  factory MemberPublic.fromJson(Map<String, dynamic> map) {
    MemberPublic member = MemberPublic();
    member.nick = Nick.fromJson(map['nick']);
    member.region = map['region'];
    member.regionName = map['region_name'];
    member.language = map['language'];
    member.token = map['token'];
    member.avatar = Avatar.fromJson(map['avatar']);

    if (map['gender'] == 'F') member.gender = Gender.F;
    else if (map['gender'] == 'M') member.gender = Gender.M;
    else member.gender = Gender.NOT_YET;

    return member;
  }
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
  M, F, NOT_YET
}

Gender parseGender(String genderExpr) =>
  genderExpr == 'M' ? Gender.M :
  genderExpr == 'F' ? Gender.F :
  Gender.NOT_YET;

String genderToString(Gender gender) =>
  gender == Gender.M ? 'M' :
  gender == Gender.F ? 'F' :
  null;

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

class Gacha {
  int remainNickGacha;
  int remainAvatarGacha;

  Gacha();

  factory Gacha.fromJson(Map<String, dynamic> map) {
    Gacha gacha = Gacha();
    gacha.remainAvatarGacha = map['remain_avatar_gacha'];
    gacha.remainNickGacha = map['remain_nick_gacha'];
    return gacha;
  }

  @override
  String toString() => "REMAIN_NICK=$remainNickGacha, REMAIN_AVATAR=$remainAvatarGacha";
}