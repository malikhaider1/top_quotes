import 'package:dartz/dartz.dart';

import '../../core/failure/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> registerUser(String username,String email, String password);
  Future<Either<Failure, String>> loginUser(String username, String password);
  Future<Either<Failure, String>> logOut(String userToken);

}