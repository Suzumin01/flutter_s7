part of 'game_genre_bloc.dart';

@immutable
sealed class GameGenreEvent {}

final class LoadGameGenresEvent extends GameGenreEvent {}