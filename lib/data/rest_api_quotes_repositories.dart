import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:top_quotes/data/quotes_of_the_day_json.dart';
import 'package:top_quotes/domain/entities/all_quotes.dart';
import 'package:top_quotes/domain/entities/quote_of_the_day.dart';

import '../domain/repositories/quotes_repositories.dart';
import 'all_quotes_json.dart';

class RestApiQuotesRepositories implements QuotesRepository {

  String api = "56d0261afaf9d821ec84ac56b71c663c";
  String userToken = "P3oGpCwqZ5pDhe3YFHNDumHiiZptZX//DZoghUh7vKGfoKibnB3WxkWqLoKzkiPaP3trmgqnUFe46s846Xxnow=="; // Replace with your user token if needed
  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://favqs.com/api/', // Replace with your API base URL
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/vnd.favqs.v2+json',
      'Authorization': 'Token token=56d0261afaf9d821ec84ac56b71c663c',// Include your API token here

    },
  ));

  @override
  Future<QuoteOfTheDay> getQuoteOfTheDay() async{
    final response = await dio.get('qotd');
    print(response.data['quote']);
    QuoteOfTheDay quoteOfTheDay = QuotesOfTheDayJson.fromJson(response.data['quote']).toDomain();
    return quoteOfTheDay;// Replace 'quotes' with your endpoint
  }

  @override
  Future<AllQuotes> getAllQuotes(int page) async{
    //type: ['author', 'tag', 'user']
    //page: 1
    //per_page: 25
    //filter: 	Type lookup or keyword search
    final response = await dio.get('quotes', queryParameters: {'page': page},options: Options(
      headers: {
        'Authorization': 'Token token=56d0261afaf9d821ec84ac56b71c663c',
        'User-Token': userToken,
        // Include your API token here
      }

    ));
    print(response.data['quotes']);
    AllQuotes allQuotes= AllQuotesJson.fromJson(response.data).toDomain();
    return allQuotes; // Replace 'quotes' with your endpoint
  }
  @override
  Future<AllQuotes> searchQuotes(String query, int page) async {
    final response = await dio.get('quotes', queryParameters: {'filter': query, 'page': page}, options: Options(
      headers: {
        'Authorization': 'Token token=56d0261afaf9d821ec84ac56b71c663c',
        'User-Token': userToken,
        // Include your API token here
      }
    ));
    print(response.data['quotes']);
    AllQuotes allQuotes = AllQuotesJson.fromJson(response.data).toDomain();
    return allQuotes; // Replace 'quotes' with your endpoint
  }
}