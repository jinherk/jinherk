import 'package:drift/drift.dart';

class Postings extends Table {

  IntColumn get id => integer().autoIncrement()();

  BoolColumn get postLike => boolean()();

  TextColumn get postTime => text()();

  TextColumn get postAuthor => text()();

}