import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/quote.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState.initial()) {
    on<SearchEvent>((event, emit) {
    });
  }
}
