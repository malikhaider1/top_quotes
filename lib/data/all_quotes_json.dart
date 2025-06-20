import 'package:top_quotes/data/quote_json.dart';

import '../domain/entities/all_quotes.dart';

class AllQuotesJson {
  final int page;
  final bool lastPage;
  final List<QuotesJson> quotes;
  AllQuotesJson({
    required this.page,
    required this.lastPage,
    required this.quotes,
  });
  factory AllQuotesJson.fromJson(Map<String, dynamic> json) {
    return AllQuotesJson(
      page: json['page'],
      lastPage: json['last_page'],
      quotes: List<QuotesJson>.from(json['quotes'].map((e) => QuotesJson.fromJson(e))),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['page'] = page;
    data['last_page'] = lastPage;
    data['quotes'] = quotes.map((e)=>e.toJson()).toList();
    return data;
  }

  AllQuotes toDomain() {
    return AllQuotes(
      page: page,
      lastPage: lastPage,
      quotes: quotes.map((e) => e.toDomain()).toList(),);
  }
}