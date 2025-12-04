import 'package:drift/drift.dart';

class GameGenres extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get imagePath => text()();
}
