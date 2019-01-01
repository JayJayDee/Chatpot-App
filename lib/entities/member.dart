class Nick {
  final String en;
  final String ko;
  final String ja;

  Nick({ this.en, this.ko, this.ja });

  factory Nick.fromJson(Map<String, dynamic> json) {
    return Nick(
      en: json['en'],
      ko: json['ko'],
      ja: json['ja']
    );
  }
}

class Member {
  Nick nick;
  String token;
  String region;
  String gender;

  Member({this.nick, this.token, this.region, this.gender});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      nick: Nick.fromJson(json['nick']),
      token: json['token'],
      region: json['region'],
      gender: json['gender']
    );
  }
}

class Auth {
  String authToken;
}