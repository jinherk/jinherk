import 'package:drift/drift.dart';

class Schedules extends Table {
  // 고유 키
  IntColumn get id => integer().autoIncrement()();

  // 내용
  TextColumn get content => text()();

  // 날짜
  DateTimeColumn get date => dateTime()();

  // 시작 시간
  IntColumn get startTime => integer()();

  // 끝나는 시간
  IntColumn get endTime => integer()();

  // 생성 날짜
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now())();
}
