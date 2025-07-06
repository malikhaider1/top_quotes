import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:top_quotes/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../core/failure/failure.dart';
class RestApiAuthRepository implements AuthRepository {
  final _appToken = "56d0261afaf9d821ec84ac56b71c663c"; //api token for favqs.com
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


  @override
  Future<Either<Failure, String>> loginUser(String username,
      String password) async {
    try {
      final response = await _dio.post(
        'session',
        data: {
          "user": {'login': username, 'password': password},
        },
        options: Options(
          headers: {
            'Authorization': 'Token token=$_appToken',
            // Include your API token here
          },
        ),
      );
      print('Login successful: ${response.data}');
      print(response.statusCode);
      print(response.data['User-Token']);
      if (response.statusCode == 200) {
        if (response.data['error_code'] != null) {
          return Left(Failure(message: response.data['message']));
        }
        return Right(response.data['User-Token']);
      }
      return Left(
          Failure(message: 'Failed to login: ${response.data["message"]}'));
    } on DioException catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> registerUser(String username,
      String email,
      String password,) async {
    try {
      final data = jsonEncode({
        'user': {'login': username, 'email': email, 'password': password},
      });
      final response = await _dio.post(
        'users',
        options: Options(headers: {
          "Authorization": 'Token token=$_appToken',
          // Include your API token here
        }),
        data: data,
      );
      if (response.statusCode == 200) {
        if (response.data['error_code'] != null) {
          return Left(Failure(message: response.data['message']));
        }
      }
      return Right(response.data['User-Token']);
    } on DioException catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logOut(String userToken) async {
    try {
      final response = await _dio.delete(
          'session',
          options: Options(
              headers: {
                'User-Token': userToken,
                'Authorization': "Token token=$_appToken",
              }));
      if (response.statusCode == 200) {
        return Right(response.statusMessage.toString());
      }
      return Left(
          Failure(message: 'Failed to logout: ${response.data["message"]}'));
    } on DioException catch (e) {
      return Left(Failure(message: e.message.toString()));
    }
  }
}