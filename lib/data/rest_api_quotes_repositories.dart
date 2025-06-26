import 'package:dio/dio.dart';
import 'package:top_quotes/data/quotes_of_the_day_json.dart';
import 'package:top_quotes/domain/entities/all_quotes.dart';
import 'package:top_quotes/domain/entities/quote_of_the_day.dart';
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
  Future<QuoteOfTheDay> getQuoteOfTheDay() async {
    final response = await dio.get('qotd');
    print(response.data['quote']);
    QuoteOfTheDay quoteOfTheDay =
        QuotesOfTheDayJson.fromJson(response.data['quote']).toDomain();
    return quoteOfTheDay; // Replace 'quotes' with your endpoint
  }

  @override
  Future<AllQuotes> getAllQuotes(int page,String userToken) async {
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
    return allQuotes; // Replace 'quotes' with your endpoint
  }

  @override
  Future<AllQuotes> searchQuotes(String query, int page, String type, String userToken) async {
    //type: ['author', 'tag', 'user']
    //page: 1
    //per_page: 25
    //filter: 	Type lookup or keyword search
    final response = await dio.get(
      'quotes',
      queryParameters: {'filter': query, 'page': page, 'type': type},
      options: Options(
        headers: {'User-Token': userToken, "Authorization": 'Token token=$api'},
      ),
    );
    AllQuotes allQuotes = AllQuotesJson.fromJson(response.data).toDomain();
    return allQuotes; // Replace 'quotes' with your endpoint
  }
}
