abstract class AuthRepository {
  Future<String> registerUser(String username,String email, String password);
  Future<String> loginUser(String username, String password);
}