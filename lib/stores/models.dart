class Member {
  String nick;
  String region;
  String language;
}

enum AuthType {
  Simple
}

class Auth {
  String token;
  AuthType authType;
}

class Room {
  int roomNo;
}