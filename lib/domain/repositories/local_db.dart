abstract class LocalDb {
  Future<void> init();
  Future<void> saveCredentials(String token, String username, String password);
  Future<void> clearCredentials();
  bool get isLoggedIn;
  String get userToken;
  String get username;
  String get password;
}