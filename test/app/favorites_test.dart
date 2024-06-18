import 'dart:async';

import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/database.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/favorites_repository.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/post_client.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/post_cell.dart';
import 'package:black_tax_and_white_benefits/app/features/settings/shared_preferences.dart';
import 'package:black_tax_and_white_benefits/app/shared/navigation_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../data/test_data.dart';
import '../helpers/helpers.dart';

class MockDatabase extends Mock implements Database {
  final List<FavoritePost> favorites = List.empty(growable: true);
  final StreamController<List<FavoritePost>> favoritesController =
      StreamController<List<FavoritePost>>();

  MockDatabase() {
    favorites.clear();
    favoritesController.add(favorites);
  }

  @override
  Stream<List<FavoritePost>> watchPosts() => favoritesController.stream;
  @override
  Future<List<FavoritePost>> getPosts() => Future.value(favorites);

  void add(FavoritePost post) {
    favorites.add(post);
    favoritesController.add(favorites);
  }

  void remove(FavoritePost post) {
    favorites.remove(post);
    favoritesController.add(favorites);
  }

  @override
  Future<void> close() async {
    await favoritesController.close();
    reset(this);
  }
}

void main() {
  Future<void> pumpApp(WidgetTester tester, Database database) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          getPostsProvider.overrideWith((ref) async => Future.value(mockPosts)),
          databaseProvider.overrideWith((ref) => database),
          sharedPreferencesProvider.overrideWith((ref) => MockSharedPreferences()),
        ],
        child: const App(),
      ),
    );
  }

  final exception = Exception('Failed');
  final mockFavoritePost = FavoritePost(id: 1, post: mockPosts.first);

  group('Test Favorite action', () {
    setUpAll(() {
      registerFallbackValue(FavoritePostsCompanion.insert(post: mockPosts.first));
    });
    testWidgets('empty list', (tester) async {
      final database = MockDatabase();

      addTearDown(database.close);

      // Load app widget.
      await pumpApp(tester, database);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(favoritesIconKey));
      await tester.pumpAndSettle();

      expect(find.text('You have nothing in your favorites.'), findsOneWidget);
    });
    testWidgets('loading', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            getPostsProvider.overrideWith((ref) async => Future.value(mockPosts)),
            favoriteListProvider.overrideWith(
                (ref) => Stream.fromFuture(Future.delayed(Duration(seconds: 2), () => mockPosts))),
            sharedPreferencesProvider.overrideWith((ref) => MockSharedPreferences()),
          ],
          child: const App(),
        ),
      );

      await tester.pumpAndSettle();

      // Navigate back to Favorites screen
      await tester.tap(find.byKey(favoritesIconKey));
      await tester.pumpAndSettle();

      expect(find.byType(PostCell), findsExactly(2));
    });
    testWidgets('error', (tester) async {
      // Load app widget.
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            getPostsProvider.overrideWith((ref) async => Future.value(mockPosts)),
            favoriteListProvider.overrideWith((ref) => throw exception),
            sharedPreferencesProvider.overrideWith((ref) => MockSharedPreferences()),
          ],
          child: const App(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(favoritesIconKey));
      await tester.pumpAndSettle();

      expect(find.text(exception.toString()), findsOneWidget);
    });
    testWidgets('add one to favorites success', (tester) async {
      final database = MockDatabase();
      when(() => database.insertFavoritePost(any())).thenAnswer((invocation) {
        database.add(mockFavoritePost);
        return Future.value(0);
      });

      addTearDown(database.close);

      // Load app widget.
      await pumpApp(tester, database);
      await tester.pumpAndSettle();

      // Make sure on home screen
      await tester.tap(find.byKey(homeIconKey));
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
      await tester.tap(find.byKey(favoritesIconKey));
      await tester.pumpAndSettle();

      expect(find.byType(PostCell), findsOneWidget);
    });
    testWidgets('add one to favorites failure', (tester) async {
      final database = MockDatabase();
      when(() => database.insertFavoritePost(any())).thenThrow(exception);
      addTearDown(database.close);

      // Load app widget.
      await pumpApp(tester, database);

      await tester.pumpAndSettle();

      // Make sure on home screen
      await tester.tap(find.byKey(homeIconKey));
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

      when(() => database.deleteFavoritePost(any())).thenAnswer((invocation) {
        database.remove(mockFavoritePost);
        return Future.value(0);
      });

      addTearDown(database.close);

      // Load app widget.
      await pumpApp(tester, database);

      // Clear favorites list and add one post
      database.add(mockFavoritePost);
      await tester.pumpAndSettle();

      // Move to Favorites screen
      await tester.tap(find.byKey(favoritesIconKey));
      await tester.pumpAndSettle();

      // Expect to find one Post in Favorites
      expect(find.byType(PostCell), findsOneWidget);

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
      final mockFavoritePost = FavoritePost(id: 1, post: mockPosts.first);
      when(() => database.deleteFavoritePost(any())).thenThrow(exception);
      addTearDown(database.close);

      // Load app widget.
      await pumpApp(tester, database);
      await tester.pumpAndSettle();

      // Clear favorites list and add one post
      database.add(mockFavoritePost);
      await tester.pumpAndSettle();

      // Move to Favorites screen
      await tester.tap(find.byKey(favoritesIconKey));
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
