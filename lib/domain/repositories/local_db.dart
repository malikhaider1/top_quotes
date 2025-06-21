abstract class LocalDb {
  get isLoggedIn => null;
  get userToken => null;
  get username => null;
  get password => null;
  Future<void> init();
  Future<void> saveCredentials(String token, String username, String password);
  Future<void> clearCredentials();
}