abstract class AuthAccessor {
  Future<String> getToken();
  Future<void> setToken(String token);
  
  Future<String> getSessionKey();
  Future<void> setSessionKey(String sessionKey);

  Future<String> getPassword();
  Future<void> setPassword(String password);
}