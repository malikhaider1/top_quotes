import 'package:dartz/dartz.dart';
import 'package:top_quotes/domain/entities/random_words.dart';
import '../../core/failure/failure.dart';

abstract class RandomWordRepository {
  Future<Either<Failure, RandomWord>> getRandomWord();
}