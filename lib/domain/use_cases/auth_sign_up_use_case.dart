import 'package:dartz/dartz.dart';
import 'package:top_quotes/domain/repositories/local_db.dart';

import '../../core/failure/failure.dart';
import '../repositories/auth_repository.dart';

class AuthSignUpUseCase {
  final AuthRepository _authRepository;
  final LocalDb _localDb;
  AuthSignUpUseCase(this._authRepository,this._localDb);

  Future<Either<Failure, String>> execute({
    required String email,
    required String password,
    required String username,
  }) async {
    final token = await _authRepository.registerUser(username, email, password);
    return token.fold(
        (failure) {
          return Left(failure);
        },
        (token) async {
          await _localDb.clearCredentials();
          await _localDb.saveCredentials(token, username, password);
          return Right(token);
          },
      );
  }
}