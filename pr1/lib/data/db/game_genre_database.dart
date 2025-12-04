import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';

import 'game_genre_table.dart';

part 'game_genre_database.g.dart';

@lazySingleton
@DriftDatabase(tables: [GameGenres])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await batch((batch) {
        batch.insertAll(gameGenres, [
          GameGenresCompanion.insert(
            title: 'Action',
            description: 'Динамичные игры с акцентом на физическое взаимодействие',
            imagePath: 'assets/images/1.jpg',
          ),
          GameGenresCompanion.insert(
            title: 'Action-adventure',
            description: 'Комбинация экшена и приключенческих элементов',
            imagePath: 'assets/images/2.jpg',
          ),
          GameGenresCompanion.insert(
            title: 'Adventure',
            description: 'Игры с упором на исследование и решение загадок',
            imagePath: 'assets/images/3.jpg',
          ),
          GameGenresCompanion.insert(
            title: 'Puzzle',
            description: 'Игры-головоломки, требующие логического мышления',
            imagePath: 'assets/images/4.jpg',
          ),
          GameGenresCompanion.insert(
            title: 'Role-playing',
            description: 'Игры с развитием персонажа и глубоким сюжетом',
            imagePath: 'assets/images/5.jpeg',
          ),
        ]);
      });
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    return driftDatabase(
      name: 'game_genres.db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  });
}
