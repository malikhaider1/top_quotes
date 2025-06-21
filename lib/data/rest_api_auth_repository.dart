import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:top_quotes/domain/repositories/auth_repository.dart';

class RestApiAuthRepository implements AuthRepository {
  final _appToken =
      "56d0261afaf9d821ec84ac56b71c663c"; //api token for favqs.com
  String? userToken;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://favqs.com/api/', // Replace with your API base URL
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/vnd.favqs.v2+json',
      },
    ),
  );

  final headers = {
    'Authorization': 'Token token=56d0261afaf9d821ec84ac56b71c663c',
  };

  @override
  Future<String> loginUser(String username, String password) async {
    final response = await _dio.post(
      'session',
      data: {
        "user": {'login': username, 'password': password},
      },
      options: Options(
        headers: {
          'Authorization':
              'Token token=$_appToken', // Include your API token here
        },
      ),
    );
    if (response.statusCode == 200) {
      // Assuming the response contains a user token
      print(response.data);
      userToken = response.data['User-Token'];
      // You can store the user token securely if needed
    } else {
      throw Exception('Failed to login: ${response.data}');
    }
    return userToken ?? '';
  }

  @override
  Future<String> registerUser(
    String username,
    String email,
    String password,
  ) async {
    final data = jsonEncode({
      'user': {'login': username, 'email': email, 'password': password},
    });
    final response = await _dio.post(
      'users',
      options: Options(headers: headers),
      data: data,
    );
    if(response.statusCode == 200){
      return response.data['User-Token'];

    } else {
      return 'Failed to register: ${response.statusMessage}';
    }
  }
}
