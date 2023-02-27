import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import '../sqlite/comment.dart';
import '../sqlite/posting.dart';
import '../sqlite/schdule.dart';
import 'package:path/path.dart' as p;
part 'drift_database.g.dart';

@DriftDatabase(tables: [
  Schedules,
  Postings,
  Comments
])

class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());
  ///스케쥴 저장
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);
  ///스케쥴 삭제
  Future<int> removeSchedule(int id)=>(delete(schedules)..where((tbl) => tbl.id.equals(id))).go();
  ///스케쥴 수정
  Future<int> updateScheduleById(int id, SchedulesCompanion data) =>
      (update(schedules)..where((tbl) => tbl.id.equals(id))).write(data);
  ///스케쥴 한번만 가져오기
  Future<Schedule> getSchedules(int id) => (select(schedules)..where((tbl) => tbl.id.equals(id))).getSingle();
  ///스케쥴 스트리밍으로 가져오기
  Stream<List<Schedule>> watchSchedules(DateTime date){
    return (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();
  }

  ///좋아요 여부 저장
  Future<int> saveLike(PostingsCompanion data) =>
      into(postings).insert(data);
  ///좋아요 여부 스트리밍으로 가져오기
  Stream<List<Posting>> getPostings(String date, String author) {
    return (select(postings)
      ..where((tbl) => tbl.postTime.equals(date))
      ..where((tbl) => tbl.postAuthor.equals(author))).watch();
  }

  ///좋아요 여부 저장
  Future<int> saveCommentLike(CommentsCompanion data) =>
      into(comments).insert(data);

  ///좋아요 여부 스트리밍으로 가져오기
  Stream<List<Comment>> getComments(String date, String author) {
    return (select(comments)
      ..where((tbl) => tbl.commentTime.equals(date))
      ..where((tbl) => tbl.commentAuthor.equals(author))).watch();
  }



  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, "db.sqlite"));
    return NativeDatabase(file);
  });
}