import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_navigation_event.dart';
part 'main_navigation_state.dart';

class MainNavigationBloc extends Bloc<MainNavigationEvent, MainNavigationState> {
  MainNavigationBloc() : super(MainNavigationInitial()) {
    on<MainNavigationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
