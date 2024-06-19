import 'package:black_tax_and_white_benefits/app/config/logger.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/database.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_repository.g.dart';

class FavoritesRepository {
  const FavoritesRepository({
    required this.database,
  });

  final Database database;

  Future<int> addFavorite(Post post) async {
    try {
      return database.insertFavoritePost(FavoritePostsCompanion.insert(post: post));
    } catch (e) {
      logger.e(e);
      return -1;
    }
  }

  Future<int> removeFavorite(Post post) async {
    try {
      final row = (await database.getPosts()).firstWhere((element) => element.post == post);
      return database.deleteFavoritePost(row.id);
    } catch (e) {
      logger.e(e);
      return -1;
    }
  }
}

@riverpod
FavoritesRepository favoritesRepository(FavoritesRepositoryRef ref) {
  final Database database = ref.watch(databaseProvider);
  return FavoritesRepository(database: database);
}

@Riverpod(keepAlive: true)
Stream<List<Post>> favoriteList(FavoriteListRef ref) {
  final Database database = ref.watch(databaseProvider);

  return database.watchPosts().map((entry) => entry.map((element) => element.post).toList());
}
