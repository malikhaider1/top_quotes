import 'package:top_quotes/domain/entities/quote_of_the_day.dart';

import '../entities/all_quotes.dart';

abstract class QuotesRepository {
  Future<QuoteOfTheDay> getQuoteOfTheDay();
  Future<AllQuotes> getAllQuotes(int page,String userToken);
  Future<AllQuotes> searchQuotes(String query, int page, String type,String userToken);
  // Future<AllQuotes> searchQuotes(String query, int page);
  // Future<AllQuotes> getQuotesByTag(String tag, int page);
  // Future<AllQuotes> getQuotesByAuthor(String author, int page);
}
