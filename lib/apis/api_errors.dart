class ApiFailureError extends Error {
  String _code;
  String _msg;

  ApiFailureError(String msg, { String code }) {
    _msg = msg;
    _code = code;
  }

  String get msg => _msg;
  String get code => _code;

  @override
  toString() => "$_msg $_code";
}