import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:top_quotes/data/quote_json.dart';
import 'package:top_quotes/data/quotes_of_the_day_json.dart';
import 'package:top_quotes/domain/entities/all_quotes.dart';
import 'package:top_quotes/domain/entities/quote_of_the_day.dart';
import '../core/failure/failure.dart';
import '../domain/entities/quote.dart';
import '../domain/repositories/quotes_repositories.dart';
import 'all_quotes_json.dart';

class RestApiQuotesRepositories implements QuotesRepository {
  // Assuming you have a LocalDb instance to manage user tokens
  String api =
      "56d0261afaf9d821ec84ac56b71c663c"; // Replace with your user token if needed
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://favqs.com/api/', // Replace with your API base URL
      headers: {
        'Content-Type': 'application/json',
        'Accept':
            'application/vnd.favqs.v2+json', // Include your API token here
      },
    ),
  );

  @override
  Future<Either<Failure, QuoteOfTheDay>> getQuoteOfTheDay() async {
    try {
      final response = await dio.get('qotd');
      print(response.data['quote']);

      QuoteOfTheDay quoteOfTheDay =
      QuotesOfTheDayJson.fromJson(response.data['quote']).toDomain();
      return Right(quoteOfTheDay);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AllQuotes>> getAllQuotes(int page, String userToken) async {
    try{
      final response = await dio.get(
        'quotes',
        queryParameters: {'page': page},
        options: Options(
          headers: {
            'User-Token': userToken,
            'Authorization': 'Token token=$api', // Include your API token here
            // Include your API token here
          },
        ),
      );
      print(response.data['quotes']);
      AllQuotes allQuotes = AllQuotesJson.fromJson(response.data).toDomain();
      return Right(allQuotes);
    }catch(e){
      return Left(Failure(message: e.toString()));
    }
    // Replace 'quotes' with your endpoint
  }

  @override
  Future<Either<Failure, AllQuotes>> searchQuotes(
    String query,
    int page,
    String type,
    String userToken,
  ) async {
    //type: ['author', 'tag', 'user']
    //page: 1
    //per_page: 25
    //filter: 	Type lookup or keyword search
    try{
      final response = await dio.get(
        'quotes',
        queryParameters: {'filter': query, 'page': page, 'type': type},
        options: Options(
          headers: {'User-Token': userToken, "Authorization": 'Token token=$api'},
        ),
      );
      AllQuotes allQuotes = AllQuotesJson.fromJson(response.data).toDomain();
      return Right(allQuotes);
    }catch(e){
      return Left(Failure(message: e.toString()));
    }// Replace 'quotes' with your endpoint
  }

  @override
  Future<Either<Failure, Quote>> getQuoteDetails(int id, String userToken) async {
    try{
      final response = await dio.get(
        'quotes/$id',
        options: Options(
          headers: {"Authorization": 'Token token=$api', 'User-Token': userToken},
        ),
      );
      Quote quote = QuotesJson.fromJson(response.data).toDomain();
      return Right(quote);
    }catch(e){
      return Left(Failure(message: e.toString()));
    }// Replace 'quotes' with your endpoint
  }

  @override
  Future<Either<Failure, AllQuotes>> fetchUserFavoritesQuotes(
    int page,
    String username,
    String userToken,
  ) async {
    try{
      final response = await dio.get(
        'quotes',
        queryParameters: {'page': page, 'filter': username, 'type': 'user'},
        options: Options(
          headers: {'User-Token': userToken, "Authorization": 'Token token=$api'},
        ),
      );

      AllQuotes allQuotes = AllQuotesJson.fromJson(response.data).toDomain();
      return Right(allQuotes);

    }catch(e){
      return Left(Failure(message: e.toString()));
    }// Replace 'quotes' with your endpoint
  }

  @override
  Future<Quote> addQuoteToFavorite(int id, String userToken) async {
    final response = await dio.put(
      'quotes/$id/fav',
      options: Options(
        headers: {"Authorization": 'Token token=$api', 'User-Token': userToken},
      ),
    );
    Quote quote = QuotesJson.fromJson(response.data).toDomain();
    return quote;
    // Replace 'quotes' with your endpoint
  }

  @override
  Future<Quote> quoteDownVote(int id, String userToken) async{
    final response = await dio.put(
      'quotes/$id/downvote',
        options: Options(
        headers: {"Authorization": 'Token token=$api', 'User-Token': userToken},
    )
    );
    Quote quote = QuotesJson.fromJson(response.data).toDomain();
    return quote;
  }

  @override
  Future<Quote> quoteUpVote(int id, String userToken) async{
    final response = await dio.put(
      'quotes/$id/upvote',
        options: Options(
        headers: {"Authorization": 'Token token=$api', 'User-Token': userToken},
    )
    );
    Quote quote = QuotesJson.fromJson(response.data).toDomain();
    return quote;
  }

  @override
  Future<Quote> removeQuoteFromFavorite(int id, String userToken) async {
  final response = await dio.put(
      'quotes/$id/unfav',
      options: Options(
      headers: {"Authorization": 'Token token=$api', 'User-Token': userToken},
  ));
  Quote quote = QuotesJson.fromJson(response.data).toDomain();
  return quote; // Replace 'quotes' with your endpoint
  }

  @override
  Future<Quote> clearVoteOnQuote(int id, String userToken) async{
    final response = await dio.put(
        'quotes/$id/clearvote',
        options: Options(
          headers: {"Authorization": 'Token token=$api', 'User-Token': userToken},
        ));
    Quote quote = QuotesJson.fromJson(response.data).toDomain();
    return quote;
  }

}
