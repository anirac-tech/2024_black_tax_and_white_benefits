// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FavoritePostsTable extends FavoritePosts
    with TableInfo<$FavoritePostsTable, FavoritePost> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritePostsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _postMeta = const VerificationMeta('post');
  @override
  late final GeneratedColumnWithTypeConverter<Post, String> post =
      GeneratedColumn<String>('post', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'))
          .withConverter<Post>($FavoritePostsTable.$converterpost);
  @override
  List<GeneratedColumn> get $columns => [id, post];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_posts';
  @override
  VerificationContext validateIntegrity(Insertable<FavoritePost> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_postMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoritePost map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoritePost(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      post: $FavoritePostsTable.$converterpost.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post'])!),
    );
  }

  @override
  $FavoritePostsTable createAlias(String alias) {
    return $FavoritePostsTable(attachedDatabase, alias);
  }

  static TypeConverter<Post, String> $converterpost = Post.converter;
}

class FavoritePost extends DataClass implements Insertable<FavoritePost> {
  final int id;
  final Post post;
  const FavoritePost({required this.id, required this.post});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['post'] =
          Variable<String>($FavoritePostsTable.$converterpost.toSql(post));
    }
    return map;
  }

  FavoritePostsCompanion toCompanion(bool nullToAbsent) {
    return FavoritePostsCompanion(
      id: Value(id),
      post: Value(post),
    );
  }

  factory FavoritePost.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoritePost(
      id: serializer.fromJson<int>(json['id']),
      post: serializer.fromJson<Post>(json['post']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'post': serializer.toJson<Post>(post),
    };
  }

  FavoritePost copyWith({int? id, Post? post}) => FavoritePost(
        id: id ?? this.id,
        post: post ?? this.post,
      );
  @override
  String toString() {
    return (StringBuffer('FavoritePost(')
          ..write('id: $id, ')
          ..write('post: $post')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, post);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoritePost && other.id == this.id && other.post == this.post);
}

class FavoritePostsCompanion extends UpdateCompanion<FavoritePost> {
  final Value<int> id;
  final Value<Post> post;
  const FavoritePostsCompanion({
    this.id = const Value.absent(),
    this.post = const Value.absent(),
  });
  FavoritePostsCompanion.insert({
    this.id = const Value.absent(),
    required Post post,
  }) : post = Value(post);
  static Insertable<FavoritePost> custom({
    Expression<int>? id,
    Expression<String>? post,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (post != null) 'post': post,
    });
  }

  FavoritePostsCompanion copyWith({Value<int>? id, Value<Post>? post}) {
    return FavoritePostsCompanion(
      id: id ?? this.id,
      post: post ?? this.post,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (post.present) {
      map['post'] = Variable<String>(
          $FavoritePostsTable.$converterpost.toSql(post.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritePostsCompanion(')
          ..write('id: $id, ')
          ..write('post: $post')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  _$DatabaseManager get managers => _$DatabaseManager(this);
  late final $FavoritePostsTable favoritePosts = $FavoritePostsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favoritePosts];
}

typedef $$FavoritePostsTableInsertCompanionBuilder = FavoritePostsCompanion
    Function({
  Value<int> id,
  required Post post,
});
typedef $$FavoritePostsTableUpdateCompanionBuilder = FavoritePostsCompanion
    Function({
  Value<int> id,
  Value<Post> post,
});

class $$FavoritePostsTableTableManager extends RootTableManager<
    _$Database,
    $FavoritePostsTable,
    FavoritePost,
    $$FavoritePostsTableFilterComposer,
    $$FavoritePostsTableOrderingComposer,
    $$FavoritePostsTableProcessedTableManager,
    $$FavoritePostsTableInsertCompanionBuilder,
    $$FavoritePostsTableUpdateCompanionBuilder> {
  $$FavoritePostsTableTableManager(_$Database db, $FavoritePostsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$FavoritePostsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$FavoritePostsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$FavoritePostsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<Post> post = const Value.absent(),
          }) =>
              FavoritePostsCompanion(
            id: id,
            post: post,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required Post post,
          }) =>
              FavoritePostsCompanion.insert(
            id: id,
            post: post,
          ),
        ));
}

class $$FavoritePostsTableProcessedTableManager extends ProcessedTableManager<
    _$Database,
    $FavoritePostsTable,
    FavoritePost,
    $$FavoritePostsTableFilterComposer,
    $$FavoritePostsTableOrderingComposer,
    $$FavoritePostsTableProcessedTableManager,
    $$FavoritePostsTableInsertCompanionBuilder,
    $$FavoritePostsTableUpdateCompanionBuilder> {
  $$FavoritePostsTableProcessedTableManager(super.$state);
}

class $$FavoritePostsTableFilterComposer
    extends FilterComposer<_$Database, $FavoritePostsTable> {
  $$FavoritePostsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<Post, Post, String> get post =>
      $state.composableBuilder(
          column: $state.table.post,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));
}

class $$FavoritePostsTableOrderingComposer
    extends OrderingComposer<_$Database, $FavoritePostsTable> {
  $$FavoritePostsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get post => $state.composableBuilder(
      column: $state.table.post,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$DatabaseManager {
  final _$Database _db;
  _$DatabaseManager(this._db);
  $$FavoritePostsTableTableManager get favoritePosts =>
      $$FavoritePostsTableTableManager(_db, _db.favoritePosts);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'12699d471af6f75534cbe8d7ba64971b10208eca';

/// See also [database].
@ProviderFor(database)
final databaseProvider = Provider<Database>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DatabaseRef = ProviderRef<Database>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
