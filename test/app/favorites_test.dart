import 'dart:async';

import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/database.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/favorites_repository.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/post_client.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/post_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../data/test_data.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  Future<void> pumpApp(WidgetTester tester, Database database) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          getPostsProvider.overrideWith((ref) async => Future.value(mockPosts)),
          databaseProvider.overrideWith((ref) => database),
        ],
        child: const App(),
      ),
    );
  }

  final exception = Exception('Failed');

  group('Test Favorite action', () {
    testWidgets('empty list', (tester) async {
      final database = MockDatabase();
      final List<FavoritePost> favorites = List.empty(growable: true);
      final StreamController<List<FavoritePost>> favoritesController =
          StreamController<List<FavoritePost>>();

      when(() => database.watchPosts()).thenAnswer((invocation) => favoritesController.stream);
      // Load app widget.
      await pumpApp(tester, database);
      favorites.clear();
      favoritesController.add(favorites);
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();

      expect(find.text('You have nothing in your favorites.'), findsOneWidget);

      favoritesController.close();
    });
    testWidgets('error', (tester) async {
      // Load app widget.
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            getPostsProvider.overrideWith((ref) async => Future.value(mockPosts)),
            favoriteListProvider.overrideWith((ref) => throw exception),
          ],
          child: const App(),
        ),
      );

      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();

      expect(find.text(exception.toString()), findsOneWidget);
    });
    testWidgets('add one to favorites success', (tester) async {
      final database = MockDatabase();
      final List<FavoritePost> favorites = List.empty(growable: true);
      final StreamController<List<FavoritePost>> favoritesController =
          StreamController<List<FavoritePost>>();
      final mockFavoritePost = FavoritePost(id: 1, post: mockPosts.first);

      when(() => database.watchPosts()).thenAnswer((invocation) => favoritesController.stream);
      when(() => database.insertFavoritePost(FavoritePostsCompanion.insert(post: mockPosts.first)))
          .thenAnswer((invocation) async {
        favorites.add(mockFavoritePost);
        favoritesController.add(favorites);
        return 0;
      });
      addTearDown(() => favoritesController.close());

      // Load app widget.
      await pumpApp(tester, database);

      // Clear favorites list
      favorites.clear();
      favoritesController.add(favorites);

      await tester.pumpAndSettle();

      // Make sure on home screen
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      // Go to Post Details
      await tester.tap(find.text('Black Tax'));
      await tester.pumpAndSettle();

      // Tap favorite
      await tester.tap(find.byIcon(Icons.favorite_outline));
      await tester.pumpAndSettle();

      // Find Icon has changed
      expect(find.byIcon(Icons.favorite), findsOneWidget);

      // Exit Details screen
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Navigate back to Favorites screen
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();

      expect(find.byType(PostCell), findsOneWidget);
    });
    testWidgets('add one to favorites failure', (tester) async {
      final database = MockDatabase();
      final List<FavoritePost> favorites = List.empty(growable: true);
      final StreamController<List<FavoritePost>> favoritesController =
          StreamController<List<FavoritePost>>();

      when(() => database.watchPosts()).thenAnswer((invocation) => favoritesController.stream);
      when(() => database.insertFavoritePost(FavoritePostsCompanion.insert(post: mockPosts.first)))
          .thenThrow(exception);
      addTearDown(() => favoritesController.close());

      // Load app widget.
      await pumpApp(tester, database);

      // Clear favorites list
      favorites.clear();
      favoritesController.add(favorites);

      await tester.pumpAndSettle();

      // Make sure on home screen
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      // Go to Post Details
      await tester.tap(find.text('Black Tax'));
      await tester.pumpAndSettle();

      // Tap favorite
      await tester.tap(find.byIcon(Icons.favorite_outline));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite_outline), findsOneWidget);

      // Exit Details screen
      await tester.pageBack();
      await tester.pumpAndSettle();
    });
    testWidgets('remove one from favorites success', (tester) async {
      final database = MockDatabase();
      final List<FavoritePost> favorites = List.empty(growable: true);
      final StreamController<List<FavoritePost>> favoritesController =
          StreamController<List<FavoritePost>>();
      final mockFavoritePost = FavoritePost(id: 1, post: mockPosts.first);

      when(() => database.watchPosts()).thenAnswer((invocation) => favoritesController.stream);
      when(() => database.getPosts()).thenAnswer((invocation) async => Future.value(favorites));
      when(() => database.deleteFavoritePost(1)).thenAnswer((invocation) async {
        favorites.remove(mockFavoritePost);
        favoritesController.add(favorites);
        return 0;
      });
      addTearDown(() => favoritesController.close());

      // Load app widget.
      await pumpApp(tester, database);

      // Clear favorites list and add one post
      favorites.clear();
      favorites.add(mockFavoritePost);
      favoritesController.add(favorites);
      await tester.pumpAndSettle();

      // Move to Favorites screen
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();

      // Go to Post Details
      await tester.tap(find.text('Black Tax'));
      await tester.pumpAndSettle();

      // Tap favorite
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();

      // Find Icon has changed
      expect(find.byIcon(Icons.favorite_outline), findsOneWidget);

      // Exit Details screen
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Expect empty list
      expect(find.text('You have nothing in your favorites.'), findsOneWidget);
    });
    testWidgets('remove one from favorites failure', (tester) async {
      final database = MockDatabase();
      final List<FavoritePost> favorites = List.empty(growable: true);
      final StreamController<List<FavoritePost>> favoritesController =
          StreamController<List<FavoritePost>>();
      final mockFavoritePost = FavoritePost(id: 1, post: mockPosts.first);

      when(() => database.watchPosts()).thenAnswer((invocation) => favoritesController.stream);
      when(() => database.getPosts()).thenAnswer((invocation) async => Future.value(favorites));
      when(() => database.deleteFavoritePost(1)).thenThrow(exception);
      addTearDown(() => favoritesController.close());

      // Load app widget.
      await pumpApp(tester, database);

      // Clear favorites list and add one post
      favorites.clear();
      favorites.add(mockFavoritePost);
      favoritesController.add(favorites);
      await tester.pumpAndSettle();

      // Move to Favorites screen
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();

      // Go to Post Details
      await tester.tap(find.text('Black Tax'));
      await tester.pumpAndSettle();

      // Tap favorite and expect error
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite), findsOneWidget);

      // Exit Details screen
      await tester.pageBack();
      await tester.pumpAndSettle();
    });
  });
}
