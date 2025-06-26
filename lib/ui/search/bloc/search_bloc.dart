import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:top_quotes/domain/entities/all_quotes.dart';
import 'package:top_quotes/domain/repositories/local_db.dart';
import 'package:top_quotes/domain/repositories/quotes_repositories.dart';

import '../../../domain/entities/quote.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<Quote> quotes = [];
  final QuotesRepository quotesRepository;
  final LocalDb localDb;
  SearchBloc(this.quotesRepository, this.localDb)
    : super(SearchState.initial()) {
    on<SearchEvent>((event, emit) {});
    on<SearchQuotesEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      try {
        final userToken = localDb.userToken;
        if(event.type == 'author') {
          final searchQuotesByAuthor = await quotesRepository.searchQuotes(
            event.query,
            event.page,
            'author',
            userToken,
          );
          emit(
            state.copyWith(
              isLoading: false,
              authorQuotes: searchQuotesByAuthor.page!=1?
                [...state.authorQuotes, ...searchQuotesByAuthor.quotes] :
                searchQuotesByAuthor.quotes,
              searchQuery: event.query,
            ),
          );
          emit(state.copyWith(authorQuotes: searchQuotesByAuthor.quotes));
        } else if(event.type == 'tag') {
          final searchQuotesByTag = await quotesRepository.searchQuotes(
            event.query,
            event.page,
            'tag',
            userToken,
          );
          emit(
            state.copyWith(
              isLoading: false,
              tagQuotes: searchQuotesByTag.page!=1?
                [...state.tagQuotes, ...searchQuotesByTag.quotes] :
                searchQuotesByTag.quotes,
              searchQuery: event.query,
            ),
          );
        } else {

          final searchQuotesOnly = await quotesRepository.searchQuotes(
            event.query,
            event.page,
            '',
            userToken,
          );
          emit(
            state.copyWith(
              isLoading: false,
              quotes: searchQuotesOnly.page!=1?
                [...state.quotes, ...searchQuotesOnly.quotes] :
                searchQuotesOnly.quotes,
              searchQuery: event.query,
            ),
          );
        }
      } catch (error) {
        emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
      }
    });
  }
}
