import 'package:dio/dio.dart';
import 'package:top_quotes/data/profile_json.dart';
import 'package:top_quotes/domain/entities/profile.dart';
import 'package:top_quotes/domain/repositories/profile_repository.dart';

class RestApiProfileRepository implements ProfileRepository{

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://favqs.com/api/', // Replace with your API base URL
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/vnd.favqs.v2+json',
        'Authorization': 'Token token=56d0261afaf9d821ec84ac56b71c663c', // API token
      },
    ),
  );

  @override
  Future<Profile> getProfile(String login, String userToken) async{
    final response = await _dio.get('users/$login',
      options: Options(
        headers: {
          "User-Token": userToken,
        }));
  Profile profile = ProfileJson.fromJson(response.data).toDomain();
    return profile;
  }
}