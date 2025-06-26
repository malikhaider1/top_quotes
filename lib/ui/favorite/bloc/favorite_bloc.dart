import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:top_quotes/domain/entities/all_quotes.dart';
import 'package:top_quotes/domain/repositories/local_db.dart';
import 'package:top_quotes/domain/repositories/quotes_repositories.dart';

import '../../../domain/entities/quote.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final QuotesRepository quotesRepository;
  final LocalDb localDb;
  FavoriteBloc(this.quotesRepository, this.localDb) : super(FavoriteState.initial()) {
    on<FavoriteEvent>((event, emit) {
    });
    on<FetchFavoriteQuotesEvent>((event, emit) async{
      try{
        emit(state.copyWith(
          isLoading: true,
          errorMessage: '',
        ));
        final allQuotes = await quotesRepository.fetchUserFavoritesQuotes(event.page, localDb.username, localDb.userToken);
        emit(state.copyWith(
          isLoading: false,
          quotes: allQuotes,
          errorMessage: '',
          page: event.page,
        ));
      } catch(error){
        emit(state.copyWith(
          isLoading: false,
          quotes: AllQuotes.empty(),
          errorMessage: error.toString(),
          page: event.page,
        ));
      }
    });


  }
}
