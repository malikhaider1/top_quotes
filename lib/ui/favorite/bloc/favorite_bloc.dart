import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/domain/entities/all_quotes.dart';
import 'package:top_quotes/domain/repositories/local_db.dart';
import 'package:top_quotes/domain/repositories/quotes_repositories.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final QuotesRepository quotesRepository;
  final LocalDb localDb;
  FavoriteBloc(this.quotesRepository, this.localDb) : super(FavoriteState.initial()) {
    on<FavoriteEvent>((event, emit) {
    });
    on<FetchFavoriteQuotesEvent>((event, emit) async{
        emit(state.copyWith(
          isLoading: true,
          errorMessage: null,
        ));
        final allQuotes = await quotesRepository.fetchUserFavoritesQuotes(event.page, localDb.username, localDb.userToken);
        allQuotes.fold((failure){
          emit(state.copyWith(
            isLoading: false,
            quotes: AllQuotes.empty(),
            errorMessage: failure.toString(),
            page: event.page,
          ));
        }, (allQuotes) {
          emit(state.copyWith(
            isLoading: false,
            quotes: allQuotes,
            page: event.page,
          ));
        });
    });


  }
}
