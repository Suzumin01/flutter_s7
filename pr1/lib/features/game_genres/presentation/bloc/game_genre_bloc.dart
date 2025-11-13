import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../data/game_genres_data.dart';
import '../../../../models/game_genre.dart';

part 'game_genre_event.dart';
part 'game_genre_state.dart';

class GameGenreBloc extends Bloc<GameGenreEvent, GameGenreState> {
  GameGenreBloc() : super(GameGenreInitial()) {
    on<LoadGameGenresEvent>((event, emit) async {
      emit(GameGenreLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      try {
        emit(GameGenreLoaded(gameGenres));
      } catch (e) {
        emit(GameGenreError('Не удалось загрузить данные: $e'));
      }
    });
  }
}