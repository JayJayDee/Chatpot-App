
class HttpRequestError extends Error {
  String _msg;
  int _status;

  HttpRequestError(String msg, int status) {
    _msg = msg;
    _status = status;
  }

  getMessage() {
    return _msg;
  }
  getStatus() {
    return _status;
  }
}