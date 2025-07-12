import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/domain/repositories/local_db.dart';
import 'package:top_quotes/domain/repositories/quotes_repositories.dart';

import '../../../domain/entities/quote.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final QuotesRepository quotesRepository;
  final LocalDb localDb;
  SearchBloc(this.quotesRepository, this.localDb)
    : super(SearchState.initial()) {
    on<ClearSearchErrorEvent>((event, emit) {
      emit(state.copyWith(errorMessage: ''));
    });
    on<SearchQuotesEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: ''));
      try {
        final userToken = localDb.userToken;
        if (event.type == 'author') {
          final searchQuotesByAuthor = await quotesRepository.searchQuotes(
            event.query,
            event.page,
            'author',
            userToken,
          );
          searchQuotesByAuthor.fold((failure){
            emit(state.copyWith(
              isLoading: false,
              errorMessage: failure.message,
            ));
          }, (searchQuotesByAuthor){
            if (searchQuotesByAuthor.page == 1) {
              emit(state.copyWith(
                authorQuotes: searchQuotesByAuthor.quotes,
                isLoading: false,
              ));
            } else {
              emit(state.copyWith(
                authorQuotes: [...state.authorQuotes, ...searchQuotesByAuthor.quotes],
                isLoading: false,
                searchQuery: event.query,
              ));
            }
          });
        } else if (event.type == 'tag') {

          final searchQuotesByTag = await quotesRepository.searchQuotes(
            event.query,
            event.page,
            'tag',
            userToken,
          );
          searchQuotesByTag.fold((failure){
            emit(state.copyWith(
              isLoading: false,
              errorMessage: failure.message,
            ));
          }, (searchQuotesByTag){
          if (searchQuotesByTag.page == 1) {
            emit(state.copyWith(
              tagQuotes: searchQuotesByTag.quotes,
              isLoading: false,
            ));
          } else {
            emit(state.copyWith(
              tagQuotes: [...state.tagQuotes, ...searchQuotesByTag.quotes],
              isLoading: false,
              searchQuery: event.query,
            ));}});
        } else {
          final searchQuotesOnly = await quotesRepository.searchQuotes(
            event.query,
            event.page,
            '',
            userToken,
          );
          searchQuotesOnly.fold((failure) {
            emit(state.copyWith(
              isLoading: false,
              errorMessage: failure.message,
            ));
          }, (searchQuotesOnly) {
            // If the page is 1, replace the quotes, otherwise append to the existing list
            if (searchQuotesOnly.page == 1) {
              emit(state.copyWith(
                quotes: searchQuotesOnly.quotes,
                isLoading: false,
              ));
            } else {
              // Append new quotes to the existing list
              emit(state.copyWith(
                quotes: [...state.quotes, ...searchQuotesOnly.quotes],
                isLoading: false,
                searchQuery: event.query,
              ));
            }
          });
        }
      } catch (error) {
        emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
      }
    });
  }
}
