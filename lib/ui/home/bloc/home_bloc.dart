import "package:flutter_bloc/flutter_bloc.dart";
import 'package:meta/meta.dart';
import 'package:top_quotes/domain/entities/all_quotes.dart';
import 'package:top_quotes/domain/entities/quote_of_the_day.dart';
import 'package:top_quotes/domain/repositories/quotes_repositories.dart';
import '../../../domain/repositories/local_db.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final QuotesRepository quotesRepository;
  final LocalDb localDb;
  HomeBloc(this.quotesRepository,this.localDb) : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) {});
    on<FetchQuoteOfTheDayEvent>((event, emit) async{
      emit(state.copyWith(isLoading: true, errorMessage: null));
     await quotesRepository
          .getQuoteOfTheDay()
          .then((quoteOfTheDay) {
            emit(
              state.copyWith(quoteOfTheDay: quoteOfTheDay, isLoading: false),
            );
          })
          .catchError((error) {
            emit(
              state.copyWith(isLoading: false, errorMessage: error.toString()),
            );
          });
    });
    on<FetchAllQuotesEvent>((event, emit) async{
      emit(state.copyWith(isLoading: true, errorMessage: null));
      print(localDb.userToken);
      await quotesRepository
          .getAllQuotes(event.page,localDb.userToken)
          .then((allQuotes) {
            emit(
              state.copyWith(allQuotes: allQuotes, isLoading: false),
            );
          })
          .catchError((error) {
            emit(
              state.copyWith(isLoading: false, errorMessage: error.toString()),
            );
          });
    });
  }
}
