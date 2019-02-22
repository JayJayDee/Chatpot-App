class Member {
  Nick nick;
  String region;
  String regionName;
  String language;
  String token;
  Gender gender;

  Member();

  factory Member.fromJson(Map<String, dynamic> map) {
    Member member = Member();
    member.nick = Nick.fromJson(map['nick']);
    member.region = map['region'];
    member.language = map['language'];
    member.token = map['token'];
    if (map['gender'] == 'F') member.gender = Gender.F;
    else if (map['gender'] == 'M') member.gender = Gender.M;
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