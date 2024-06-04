import 'dart:developer';

import 'package:black_tax_and_white_benefits/app/features/posts/data/database.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_repository.g.dart';

@riverpod
class FavoritesRepository extends _$FavoritesRepository {
  @override
  FavoritesRepository build() => FavoritesRepository();

  Future<int> addFavorite(Post post) async {
    final database = ref.read(databaseProvider);

    try {
      return database.insertFavoritePost(FavoritePostsCompanion.insert(post: post));
    } on Exception {
      log('[ERROR] could not insert post.');
      return -1;
    }
  }

  Future<int> removeFavorite(Post post) async {
    final database = ref.read(databaseProvider);

    try {
      final row = (await database.getPosts()).firstWhere((element) => element.post == post);
      return database.deleteFavoritePost(row.id);
    } on Exception {
      log('[ERROR] could not remove post.');
      return -1;
    }
  }
}

@Riverpod(keepAlive: true)
Stream<List<Post>> favoriteList(FavoriteListRef ref) {
  final database = ref.watch(databaseProvider);

  return database.watchPosts().map((entry) => entry.map((element) => element.post).toList());
}
