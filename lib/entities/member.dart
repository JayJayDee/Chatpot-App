class Member {
  Nick nick;
  String token;
  Gender gender;

  Member();
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