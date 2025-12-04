import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/repositories/game_genre_repository.dart';
import '../../../../models/game_genre.dart';


part 'game_genre_event.dart';
part 'game_genre_state.dart';

@injectable
class GameGenreBloc extends Bloc<GameGenreEvent, GameGenreState> {
  final GameGenreRepository repository;

  GameGenreBloc(this.repository) : super(GameGenreInitial()) {
    on<LoadGameGenresEvent>((event, emit) async {
      emit(GameGenreLoading());
      try {
        final genres = await repository.getAllGenres();
        await Future.delayed(const Duration(milliseconds: 300));
        emit(GameGenreLoaded(genres));
      } catch (e) {
        emit(GameGenreError('Не удалось загрузить данные: $e'));
      }
    });
  }
}
