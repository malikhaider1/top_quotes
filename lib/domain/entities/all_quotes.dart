import 'package:equatable/equatable.dart';
import 'package:top_quotes/domain/entities/quote.dart';

import '../../data/models/quote_json.dart';

class AllQuotes extends Equatable{
  final int page;
  final bool lastPage;
  final List<Quote> quotes;
  const AllQuotes({
    required this.page,
    required this.lastPage,
    required this.quotes,

  });
factory AllQuotes.empty() {
    return AllQuotes(
      page: 0,
      lastPage: true,
      quotes: [],
    );
  }

  @override
  List<Object?> get props => [page, lastPage, quotes];
}