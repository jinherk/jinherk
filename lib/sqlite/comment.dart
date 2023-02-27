import 'package:drift/drift.dart';

class Comments extends Table {
  ///고유값
  IntColumn get id => integer().autoIncrement()();

  ///댓글 좋아요 여부
  BoolColumn get commentLike => boolean()();

  ///필터링용 댓글 작성 시간
  TextColumn get commentTime => text()();

  ///필터링용 댓글 저자
  TextColumn get commentAuthor => text()();


}