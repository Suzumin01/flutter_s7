import 'package:injectable/injectable.dart';

import '../../models/game_genre.dart';
import '../db/game_genre_database.dart';

@lazySingleton
class GameGenreRepository {
  final AppDatabase _db;

  GameGenreRepository(this._db);

  Future<List<GameGenreModel>> getAllGenres() async {
    final rows = await _db.select(_db.gameGenres).get();

    return rows.map((r) {
      return GameGenreModel(
        id: r.id,
        title: r.title,
        description: r.description,
        imagePath: r.imagePath,
      );
    }).toList();
  }
}
