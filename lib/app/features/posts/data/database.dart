import 'dart:io';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

//coverage:ignore-start
class FavoritePosts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get post => text().unique().map(Post.converter)();
}

@DriftDatabase(tables: [FavoritePosts])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<FavoritePost>> watchPosts() => select(favoritePosts).watch();
  Future<List<FavoritePost>> getPosts() async => await select(favoritePosts).get();

  Future<int> insertFavoritePost(FavoritePostsCompanion entry) => into(favoritePosts).insert(entry);

  Future<int> deleteFavoritePost(int entryId) =>
      (delete(favoritePosts)..where((t) => t.id.equals(entryId))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
//coverage:ignore-end

final databaseProvider = Provider<Database>((ref) => Database());
