import 'package:dartz/dartz.dart';
import 'package:top_quotes/domain/repositories/local_db.dart';

import '../../core/failure/failure.dart';
import '../repositories/auth_repository.dart';

class AuthLoginUseCase {
  final AuthRepository authRepository;
  final LocalDb localDb;
  AuthLoginUseCase(
    this.authRepository,
    this.localDb,
  );

  Future<Either<Failure, String>> execute(String username, String password) async {
    final token = await authRepository.loginUser(username, password);
    return token.fold(
      (failure) async {
        return Left(failure);
      },
      (token) async {
        await localDb.clearCredentials();
        await localDb.saveCredentials(token, username, password);
        return Right(token);
      },
    );
  }
}