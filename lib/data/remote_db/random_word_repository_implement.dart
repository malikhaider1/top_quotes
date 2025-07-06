import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:top_quotes/data/models/random_word_json.dart';
import 'package:top_quotes/domain/entities/random_words.dart';
import 'package:top_quotes/domain/repositories/random_word_repository.dart';
import '../../core/failure/failure.dart';

class RandomWordRepositoryImp implements RandomWordRepository {
  final _appToken = "56d0261afaf9d821ec84ac56b71c663c"; //api token for favqs.com
  String? userToken;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://my-cloudinary-worker.mussabayyub4.workers.dev/', // Replace with your API base URL
    ),
  );


  @override
  Future<Either<Failure, RandomWord>> getRandomWord() async {
    try {
      final response = await _dio.get('random-words',queryParameters: {
        "count": 250,
      });
      //print(response.data);
       RandomWord randomWord = RandomWordJson.fromJson(response.data).toDomain();
      return Right(randomWord);
    } catch (e) {
      return Left(Failure(message: 'Failed to fetch random word: $e'));
    }
  }
}