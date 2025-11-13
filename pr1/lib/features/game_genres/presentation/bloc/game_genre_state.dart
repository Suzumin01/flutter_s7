part of 'game_genre_bloc.dart';

@immutable
sealed class GameGenreState {}

final class GameGenreInitial extends GameGenreState {}

final class GameGenreLoading extends GameGenreState {}

final class GameGenreLoaded extends GameGenreState {
  final List<GameGenre> gameGenres;
  GameGenreLoaded(this.gameGenres);
}

final class GameGenreError extends GameGenreState {
  final String message;
  GameGenreError(this.message);
}