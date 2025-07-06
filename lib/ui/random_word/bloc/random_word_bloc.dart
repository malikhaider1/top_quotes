import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../core/download_image/download_image.dart';
import '../../../domain/entities/random_words.dart';
import '../../../domain/repositories/random_word_repository.dart';

part 'random_word_event.dart';
part 'random_word_state.dart';

class RandomWordBloc extends Bloc<RandomWordEvent, RandomWordState> {
  final RandomWordRepository randomWordRepository;
  RandomWordBloc(this.randomWordRepository) : super(RandomWordState.initial()) {
    on<ClearRandomWordErrorEvent>(_clearRandomWordErrorEvent);
    on<FetchRandomWordImagesEvent>(_fetchRandomWordImagesEvent);
    on<DownloadRandomWordImageEvent>(_downloadRandomWordImageEvent);
    on<SetImageUrlEvent>(_setImageUrlEvent);
  }
  Future<void> _fetchRandomWordImagesEvent(
    FetchRandomWordImagesEvent event,
    Emitter<RandomWordState> emit,
  ) async {
    await randomWordRepository
        .getRandomWord()
        .then((result) {
          emit(state.copyWith(isLoading: true, errorMessage: ''));
          result.fold(
            (failure) {
              emit(
                state.copyWith(isLoading: false, errorMessage: failure.message),
              );
            },
            (randomWords) {
              emit(
                state.copyWith(
                  randomWord: randomWords,
                  isLoading: false,
                  errorMessage: '',
                ),
              );
            },
          );
        })
        .catchError((error) {
          emit(
            state.copyWith(isLoading: false, errorMessage: error.toString()),
          );
        });
  }

  Future<void> _clearRandomWordErrorEvent(
    ClearRandomWordErrorEvent event,
    Emitter<RandomWordState> emit,
  ) async {
    emit(state.copyWith(errorMessage: ''));
  }

  Future<void> _downloadRandomWordImageEvent(
    DownloadRandomWordImageEvent event,
    Emitter<RandomWordState> emit,
  ) async {
    await downloadAndSaveImageToGallery(event.imageUrl);
  }

  Future<void> _setImageUrlEvent(
    SetImageUrlEvent event,
    Emitter<RandomWordState> emit,
  ) async {
    emit(state.copyWith(imageUrl: event.imageUrl));
  }
}
