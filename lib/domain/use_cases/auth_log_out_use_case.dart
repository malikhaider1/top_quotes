import 'package:dartz/dartz.dart';

import '../../core/failure/failure.dart';
import '../repositories/auth_repository.dart';
import '../repositories/local_db.dart';

class AuthLogOutUseCase {
  final AuthRepository _authRepository;
  final LocalDb _localDb;
  AuthLogOutUseCase(this._authRepository, this._localDb);

  Future<Either<Failure,String>> execute() async {
   final response=  await _authRepository.logOut(_localDb.userToken);
    return response.fold(
        (failure) => Left(failure),
        (message) async {
          await _localDb.clearCredentials();
          return Right(message);
        },
      );
  }
}