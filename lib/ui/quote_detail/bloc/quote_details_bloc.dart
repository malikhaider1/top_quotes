import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:top_quotes/domain/repositories/quotes_repositories.dart';

import '../../../domain/entities/quote.dart';
import '../../../domain/repositories/local_db.dart';

part 'quote_details_event.dart';
part 'quote_details_state.dart';

class QuoteDetailsBloc extends Bloc<QuoteDetailsEvent, QuoteDetailsState> {
  final QuotesRepository quotesRepository;
  final LocalDb localDb;
  QuoteDetailsBloc(this.quotesRepository, this.localDb)
    : super(QuoteDetailsState.initial()) {
    on<QuoteDetailsEvent>((event, emit) {});
    on<FetchQuoteDetailsEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      try {
        final quote = await quotesRepository.getQuoteDetails(
          event.quoteId,
          localDb.userToken,
        );
        emit(
          state.copyWith(isLoading: false, quote: quote, errorMessage: null),
        );
      } catch (error) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage:
                error is Exception
                    ? error.toString()
                    : 'An unknown error occurred',
          ),
        );
      }
      // Simulate fetching quote details
      // Assuming we have a method to fetch quote details by ID
    });
  }
}
