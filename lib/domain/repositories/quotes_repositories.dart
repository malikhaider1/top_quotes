import 'package:top_quotes/domain/entities/quote.dart';
import 'package:top_quotes/domain/entities/quote_of_the_day.dart';

import '../entities/all_quotes.dart';

abstract class QuotesRepository {
  Future<QuoteOfTheDay> getQuoteOfTheDay();
  Future<AllQuotes> getAllQuotes(int page,String userToken);
  Future<AllQuotes> searchQuotes(String query, int page, String type,String userToken);
  Future<Quote> getQuoteDetails(int id,String userToken);
  Future<AllQuotes> fetchUserFavoritesQuotes(int page, String username, String userToken);
  Future<Quote> addQuoteToFavorite(int id, String userToken);
  Future<Quote> quoteUpVote(int id, String userToken);
  Future<Quote> quoteDownVote(int id, String userToken);
  Future<Quote> clearVoteOnQuote(int id, String userToken);
  Future<Quote> removeQuoteFromFavorite(int id, String userToken);


  // Future<Quote> addQuoteToFavorite(Quote quote, String userToken);
  // Future<AllQuotes> searchQuotes(String query, int page);
  // Future<AllQuotes> getQuotesByTag(String tag, int page);
  // Future<AllQuotes> getQuotesByAuthor(String author, int page);
}
