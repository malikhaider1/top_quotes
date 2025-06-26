import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quote_details_event.dart';
part 'quote_details_state.dart';

class QuoteDetailsBloc extends Bloc<QuoteDetailsEvent, QuoteDetailsState> {
  QuoteDetailsBloc() : super(QuoteDetailsInitial()) {
    on<QuoteDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
