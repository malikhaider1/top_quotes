import "package:flutter_bloc/flutter_bloc.dart";
import 'package:meta/meta.dart';
import 'package:top_quotes/domain/entities/all_quotes.dart';
import 'package:top_quotes/domain/entities/quote_of_the_day.dart';
import 'package:top_quotes/domain/repositories/quotes_repositories.dart';
import '../../../domain/entities/quote.dart';
import '../../../domain/repositories/local_db.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final QuotesRepository quotesRepository;
  final LocalDb localDb;
  HomeBloc(this.quotesRepository, this.localDb) : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) {});
    on<FetchQuoteOfTheDayEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      final result = await quotesRepository.getQuoteOfTheDay();
      result.fold(
        (failure) {
          emit(
            state.copyWith(isLoading: false, errorMessage: failure.toString()),
          );
        },
        (quoteOfTheDay) {
          emit(state.copyWith(quoteOfTheDay: quoteOfTheDay, isLoading: false));
        },
      );
    });

    on<FetchAllQuotesEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      await quotesRepository
          .getAllQuotes(event.page, localDb.userToken)
          .then((allQuotes) {
            allQuotes.fold(
              (failure) {
                emit(
                  state.copyWith(isLoading: false, errorMessage: failure.toString()),
                );
              },
              (allQuotes) {
                if (event.page == 1) {
                  emit(state.copyWith(quotes: allQuotes.quotes, isLoading: false));
                } else {
                  emit(
                    state.copyWith(
                      quotes: [...state.quotes, ...allQuotes.quotes],
                      isLoading: false,
                    ),
                  );
                }
              },
            );

          });
    });
  }
}
