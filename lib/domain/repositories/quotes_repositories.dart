import 'package:top_quotes/domain/entities/quote.dart';
import 'package:top_quotes/domain/entities/quote_of_the_day.dart';
import 'package:dartz/dartz.dart';
import '../../core/failure/failure.dart';
import '../entities/all_quotes.dart';

abstract class QuotesRepository {
  Future<Either<Failure, QuoteOfTheDay>> getQuoteOfTheDay();
  Future<Either<Failure, AllQuotes>> getAllQuotes(int page, String userToken);
  Future<Either<Failure, AllQuotes>> searchQuotes(String query, int page, String type,String userToken);
  Future<Either<Failure, AllQuotes>> fetchUserFavoritesQuotes(int page, String username, String userToken);
  Future<Either<Failure, Quote>> getQuoteDetails(int id,String userToken);
  Future<Either<Failure, Quote>> addQuoteToFavorite(int id, String userToken);
  Future<Either<Failure, Quote>> quoteUpVote(int id, String userToken);
  Future<Either<Failure, Quote>> quoteDownVote(int id, String userToken);
  Future<Either<Failure, Quote>> clearVoteOnQuote(int id, String userToken);
  Future<Either<Failure, Quote>> removeQuoteFromFavorite(int id, String userToken);
}
