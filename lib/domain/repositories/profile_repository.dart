import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile(String login,String userToken);
}