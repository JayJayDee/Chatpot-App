class ApiFailureError extends Error {
  String _code;
  String _msg;
  int _status;

  ApiFailureError(String msg, int status, { String code }) {
    _msg = msg;
    _code = code;
    _status = status;
  }

  String get msg => _msg;
  String get code => _code;
  int get status => _status;

  @override
  toString() => "($_status) $_msg $_code";
}

class ApiSessionExpiredError extends ApiFailureError {
  ApiSessionExpiredError(): super(
    'SESSION_EXPIRED', 401, code: 'SESSION_EXPIRED');
}