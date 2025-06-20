abstract class AuthRepository {
  Future<void> registerUser(String username,String email, String password);
  Future<String> loginUser(String username, String password);
}