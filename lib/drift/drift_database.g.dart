// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $SchedulesTable extends Schedules
    with TableInfo<$SchedulesTable, Schedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<int> startTime = GeneratedColumn<int>(
      'start_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<int> endTime = GeneratedColumn<int>(
      'end_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns =>
      [id, content, date, startTime, endTime, createdAt];
  @override
  String get aliasedName => _alias ?? 'schedules';
  @override
  String get actualTableName => 'schedules';
  @override
  VerificationContext validateIntegrity(Insertable<Schedule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Schedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Schedule(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_time'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SchedulesTable createAlias(String alias) {
    return $SchedulesTable(attachedDatabase, alias);
  }
}

class Schedule extends DataClass implements Insertable<Schedule> {
  final int id;
  final String content;
  final DateTime date;
  final int startTime;
  final int endTime;
  final DateTime createdAt;
  const Schedule(
      {required this.id,
      required this.content,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['date'] = Variable<DateTime>(date);
    map['start_time'] = Variable<int>(startTime);
    map['end_time'] = Variable<int>(endTime);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SchedulesCompanion toCompanion(bool nullToAbsent) {
    return SchedulesCompanion(
      id: Value(id),
      content: Value(content),
      date: Value(date),
      startTime: Value(startTime),
      endTime: Value(endTime),
      createdAt: Value(createdAt),
    );
  }

  factory Schedule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Schedule(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      date: serializer.fromJson<DateTime>(json['date']),
      startTime: serializer.fromJson<int>(json['startTime']),
      endTime: serializer.fromJson<int>(json['endTime']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'date': serializer.toJson<DateTime>(date),
      'startTime': serializer.toJson<int>(startTime),
      'endTime': serializer.toJson<int>(endTime),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Schedule copyWith(
          {int? id,
          String? content,
          DateTime? date,
          int? startTime,
          int? endTime,
          DateTime? createdAt}) =>
      Schedule(
        id: id ?? this.id,
        content: content ?? this.content,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('Schedule(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, content, date, startTime, endTime, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Schedule &&
          other.id == this.id &&
          other.content == this.content &&
          other.date == this.date &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.createdAt == this.createdAt);
}

class SchedulesCompanion extends UpdateCompanion<Schedule> {
  final Value<int> id;
  final Value<String> content;
  final Value<DateTime> date;
  final Value<int> startTime;
  final Value<int> endTime;
  final Value<DateTime> createdAt;
  const SchedulesCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.date = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SchedulesCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    required DateTime date,
    required int startTime,
    required int endTime,
    this.createdAt = const Value.absent(),
  })  : content = Value(content),
        date = Value(date),
        startTime = Value(startTime),
        endTime = Value(endTime);
  static Insertable<Schedule> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<DateTime>? date,
    Expression<int>? startTime,
    Expression<int>? endTime,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (date != null) 'date': date,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SchedulesCompanion copyWith(
      {Value<int>? id,
      Value<String>? content,
      Value<DateTime>? date,
      Value<int>? startTime,
      Value<int>? endTime,
      Value<DateTime>? createdAt}) {
    return SchedulesCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<int>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<int>(endTime.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchedulesCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PostingsTable extends Postings with TableInfo<$PostingsTable, Posting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PostingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _postLikeMeta =
      const VerificationMeta('postLike');
  @override
  late final GeneratedColumn<bool> postLike =
      GeneratedColumn<bool>('post_like', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("post_like" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _postTimeMeta =
      const VerificationMeta('postTime');
  @override
  late final GeneratedColumn<String> postTime = GeneratedColumn<String>(
      'post_time', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _postAuthorMeta =
      const VerificationMeta('postAuthor');
  @override
  late final GeneratedColumn<String> postAuthor = GeneratedColumn<String>(
      'post_author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, postLike, postTime, postAuthor];
  @override
  String get aliasedName => _alias ?? 'postings';
  @override
  String get actualTableName => 'postings';
  @override
  VerificationContext validateIntegrity(Insertable<Posting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('post_like')) {
      context.handle(_postLikeMeta,
          postLike.isAcceptableOrUnknown(data['post_like']!, _postLikeMeta));
    } else if (isInserting) {
      context.missing(_postLikeMeta);
    }
    if (data.containsKey('post_time')) {
      context.handle(_postTimeMeta,
          postTime.isAcceptableOrUnknown(data['post_time']!, _postTimeMeta));
    } else if (isInserting) {
      context.missing(_postTimeMeta);
    }
    if (data.containsKey('post_author')) {
      context.handle(
          _postAuthorMeta,
          postAuthor.isAcceptableOrUnknown(
              data['post_author']!, _postAuthorMeta));
    } else if (isInserting) {
      context.missing(_postAuthorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Posting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Posting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      postLike: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}post_like'])!,
      postTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post_time'])!,
      postAuthor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post_author'])!,
    );
  }

  @override
  $PostingsTable createAlias(String alias) {
    return $PostingsTable(attachedDatabase, alias);
  }
}

class Posting extends DataClass implements Insertable<Posting> {
  final int id;
  final bool postLike;
  final String postTime;
  final String postAuthor;
  const Posting(
      {required this.id,
      required this.postLike,
      required this.postTime,
      required this.postAuthor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['post_like'] = Variable<bool>(postLike);
    map['post_time'] = Variable<String>(postTime);
    map['post_author'] = Variable<String>(postAuthor);
    return map;
  }

  PostingsCompanion toCompanion(bool nullToAbsent) {
    return PostingsCompanion(
      id: Value(id),
      postLike: Value(postLike),
      postTime: Value(postTime),
      postAuthor: Value(postAuthor),
    );
  }

  factory Posting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Posting(
      id: serializer.fromJson<int>(json['id']),
      postLike: serializer.fromJson<bool>(json['postLike']),
      postTime: serializer.fromJson<String>(json['postTime']),
      postAuthor: serializer.fromJson<String>(json['postAuthor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'postLike': serializer.toJson<bool>(postLike),
      'postTime': serializer.toJson<String>(postTime),
      'postAuthor': serializer.toJson<String>(postAuthor),
    };
  }

  Posting copyWith(
          {int? id, bool? postLike, String? postTime, String? postAuthor}) =>
      Posting(
        id: id ?? this.id,
        postLike: postLike ?? this.postLike,
        postTime: postTime ?? this.postTime,
        postAuthor: postAuthor ?? this.postAuthor,
      );
  @override
  String toString() {
    return (StringBuffer('Posting(')
          ..write('id: $id, ')
          ..write('postLike: $postLike, ')
          ..write('postTime: $postTime, ')
          ..write('postAuthor: $postAuthor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, postLike, postTime, postAuthor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Posting &&
          other.id == this.id &&
          other.postLike == this.postLike &&
          other.postTime == this.postTime &&
          other.postAuthor == this.postAuthor);
}

class PostingsCompanion extends UpdateCompanion<Posting> {
  final Value<int> id;
  final Value<bool> postLike;
  final Value<String> postTime;
  final Value<String> postAuthor;
  const PostingsCompanion({
    this.id = const Value.absent(),
    this.postLike = const Value.absent(),
    this.postTime = const Value.absent(),
    this.postAuthor = const Value.absent(),
  });
  PostingsCompanion.insert({
    this.id = const Value.absent(),
    required bool postLike,
    required String postTime,
    required String postAuthor,
  })  : postLike = Value(postLike),
        postTime = Value(postTime),
        postAuthor = Value(postAuthor);
  static Insertable<Posting> custom({
    Expression<int>? id,
    Expression<bool>? postLike,
    Expression<String>? postTime,
    Expression<String>? postAuthor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (postLike != null) 'post_like': postLike,
      if (postTime != null) 'post_time': postTime,
      if (postAuthor != null) 'post_author': postAuthor,
    });
  }

  PostingsCompanion copyWith(
      {Value<int>? id,
      Value<bool>? postLike,
      Value<String>? postTime,
      Value<String>? postAuthor}) {
    return PostingsCompanion(
      id: id ?? this.id,
      postLike: postLike ?? this.postLike,
      postTime: postTime ?? this.postTime,
      postAuthor: postAuthor ?? this.postAuthor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (postLike.present) {
      map['post_like'] = Variable<bool>(postLike.value);
    }
    if (postTime.present) {
      map['post_time'] = Variable<String>(postTime.value);
    }
    if (postAuthor.present) {
      map['post_author'] = Variable<String>(postAuthor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostingsCompanion(')
          ..write('id: $id, ')
          ..write('postLike: $postLike, ')
          ..write('postTime: $postTime, ')
          ..write('postAuthor: $postAuthor')
          ..write(')'))
        .toString();
  }
}

class $CommentsTable extends Comments with TableInfo<$CommentsTable, Comment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _commentLikeMeta =
      const VerificationMeta('commentLike');
  @override
  late final GeneratedColumn<bool> commentLike =
      GeneratedColumn<bool>('comment_like', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("comment_like" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _commentTimeMeta =
      const VerificationMeta('commentTime');
  @override
  late final GeneratedColumn<String> commentTime = GeneratedColumn<String>(
      'comment_time', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _commentAuthorMeta =
      const VerificationMeta('commentAuthor');
  @override
  late final GeneratedColumn<String> commentAuthor = GeneratedColumn<String>(
      'comment_author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, commentLike, commentTime, commentAuthor];
  @override
  String get aliasedName => _alias ?? 'comments';
  @override
  String get actualTableName => 'comments';
  @override
  VerificationContext validateIntegrity(Insertable<Comment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('comment_like')) {
      context.handle(
          _commentLikeMeta,
          commentLike.isAcceptableOrUnknown(
              data['comment_like']!, _commentLikeMeta));
    } else if (isInserting) {
      context.missing(_commentLikeMeta);
    }
    if (data.containsKey('comment_time')) {
      context.handle(
          _commentTimeMeta,
          commentTime.isAcceptableOrUnknown(
              data['comment_time']!, _commentTimeMeta));
    } else if (isInserting) {
      context.missing(_commentTimeMeta);
    }
    if (data.containsKey('comment_author')) {
      context.handle(
          _commentAuthorMeta,
          commentAuthor.isAcceptableOrUnknown(
              data['comment_author']!, _commentAuthorMeta));
    } else if (isInserting) {
      context.missing(_commentAuthorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Comment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Comment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      commentLike: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}comment_like'])!,
      commentTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment_time'])!,
      commentAuthor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment_author'])!,
    );
  }

  @override
  $CommentsTable createAlias(String alias) {
    return $CommentsTable(attachedDatabase, alias);
  }
}

class Comment extends DataClass implements Insertable<Comment> {
  ///고유값
  final int id;

  ///댓글 좋아요 여부
  final bool commentLike;

  ///필터링용 댓글 작성 시간
  final String commentTime;

  ///필터링용 댓글 저자
  final String commentAuthor;
  const Comment(
      {required this.id,
      required this.commentLike,
      required this.commentTime,
      required this.commentAuthor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['comment_like'] = Variable<bool>(commentLike);
    map['comment_time'] = Variable<String>(commentTime);
    map['comment_author'] = Variable<String>(commentAuthor);
    return map;
  }

  CommentsCompanion toCompanion(bool nullToAbsent) {
    return CommentsCompanion(
      id: Value(id),
      commentLike: Value(commentLike),
      commentTime: Value(commentTime),
      commentAuthor: Value(commentAuthor),
    );
  }

  factory Comment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Comment(
      id: serializer.fromJson<int>(json['id']),
      commentLike: serializer.fromJson<bool>(json['commentLike']),
      commentTime: serializer.fromJson<String>(json['commentTime']),
      commentAuthor: serializer.fromJson<String>(json['commentAuthor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'commentLike': serializer.toJson<bool>(commentLike),
      'commentTime': serializer.toJson<String>(commentTime),
      'commentAuthor': serializer.toJson<String>(commentAuthor),
    };
  }

  Comment copyWith(
          {int? id,
          bool? commentLike,
          String? commentTime,
          String? commentAuthor}) =>
      Comment(
        id: id ?? this.id,
        commentLike: commentLike ?? this.commentLike,
        commentTime: commentTime ?? this.commentTime,
        commentAuthor: commentAuthor ?? this.commentAuthor,
      );
  @override
  String toString() {
    return (StringBuffer('Comment(')
          ..write('id: $id, ')
          ..write('commentLike: $commentLike, ')
          ..write('commentTime: $commentTime, ')
          ..write('commentAuthor: $commentAuthor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, commentLike, commentTime, commentAuthor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Comment &&
          other.id == this.id &&
          other.commentLike == this.commentLike &&
          other.commentTime == this.commentTime &&
          other.commentAuthor == this.commentAuthor);
}

class CommentsCompanion extends UpdateCompanion<Comment> {
  final Value<int> id;
  final Value<bool> commentLike;
  final Value<String> commentTime;
  final Value<String> commentAuthor;
  const CommentsCompanion({
    this.id = const Value.absent(),
    this.commentLike = const Value.absent(),
    this.commentTime = const Value.absent(),
    this.commentAuthor = const Value.absent(),
  });
  CommentsCompanion.insert({
    this.id = const Value.absent(),
    required bool commentLike,
    required String commentTime,
    required String commentAuthor,
  })  : commentLike = Value(commentLike),
        commentTime = Value(commentTime),
        commentAuthor = Value(commentAuthor);
  static Insertable<Comment> custom({
    Expression<int>? id,
    Expression<bool>? commentLike,
    Expression<String>? commentTime,
    Expression<String>? commentAuthor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (commentLike != null) 'comment_like': commentLike,
      if (commentTime != null) 'comment_time': commentTime,
      if (commentAuthor != null) 'comment_author': commentAuthor,
    });
  }

  CommentsCompanion copyWith(
      {Value<int>? id,
      Value<bool>? commentLike,
      Value<String>? commentTime,
      Value<String>? commentAuthor}) {
    return CommentsCompanion(
      id: id ?? this.id,
      commentLike: commentLike ?? this.commentLike,
      commentTime: commentTime ?? this.commentTime,
      commentAuthor: commentAuthor ?? this.commentAuthor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (commentLike.present) {
      map['comment_like'] = Variable<bool>(commentLike.value);
    }
    if (commentTime.present) {
      map['comment_time'] = Variable<String>(commentTime.value);
    }
    if (commentAuthor.present) {
      map['comment_author'] = Variable<String>(commentAuthor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommentsCompanion(')
          ..write('id: $id, ')
          ..write('commentLike: $commentLike, ')
          ..write('commentTime: $commentTime, ')
          ..write('commentAuthor: $commentAuthor')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $SchedulesTable schedules = $SchedulesTable(this);
  late final $PostingsTable postings = $PostingsTable(this);
  late final $CommentsTable comments = $CommentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [schedules, postings, comments];
}
