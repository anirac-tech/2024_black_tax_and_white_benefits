import 'package:black_tax_and_white_benefits/app/features/posts/data/favorites_repository.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/post_client.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/post_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../data/test_data.dart';

class MockPostClient extends Mock implements PostClient {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  ProviderContainer createContainer(PostClient postClient) {
    final container = ProviderContainer(
      overrides: [
        getPostsProvider.overrideWith((ref) async {
          await Future<void>.delayed(const Duration(seconds: 1));
          return postClient.getPosts(100);
        }),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  Future<void> pumpApp(WidgetTester tester, PostClient postClient) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          getPostsProvider.overrideWith((ref) async {
            await Future<void>.delayed(const Duration(seconds: 1));
            return postClient.getPosts(100);
          }),
          favoriteListProvider.overrideWith((ref) => Stream.empty()),
        ],
        child: const App(),
      ),
    );
  }

  setUpAll(() {
    registerFallbackValue(const AsyncData<List<Post>>([]));
  });

  group('Test PostClient and getPosts Provider', () {
    test('success', () async {
      final postClient = MockPostClient();

      when(() => postClient.getPosts(100))
          .thenAnswer((invocation) async => Future.value(mockPosts));

      final container = createContainer(postClient);
      final listener = Listener<AsyncValue<List<Post>>>();

      container.listen<AsyncValue<List<Post>>>(
        getPostsProvider,
        listener.call,
        fireImmediately: true,
      );

      verifyNever(() => listener(null, const AsyncData<List<Post>>([])));

      // Act
      final posts = await container.read(getPostsProvider.future);

      // Assert
      verifyInOrder([
        () => listener(null, const AsyncLoading<List<Post>>()),
        () => listener(
              const AsyncLoading<List<Post>>(),
              any(that: isA<AsyncData<List<Post>>>()),
            ),
      ]);

      expect(posts.length, 2);
    });
    test('failure', () async {
      final postClient = MockPostClient();
      final exception = Exception('Posts connection failed');
      when(() => postClient.getPosts(100)).thenThrow(exception);

      final container = createContainer(postClient);
      final listener = Listener<AsyncValue<List<Post>>>();

      container.listen<AsyncValue<List<Post>>>(
        getPostsProvider,
        listener.call,
        fireImmediately: true,
      );

      const data = AsyncData<List<Post>>([]);
      verifyNever(() => listener(null, data));

      await expectLater(
        () async => container.read(getPostsProvider.future),
        throwsA(isA<Exception>()),
      );
      // verify
      verifyInOrder([
        () => listener(null, const AsyncLoading<List<Post>>()),
        () => listener(
              // ignore: strict_raw_type
              any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>()),
            ),
      ]);
      verifyNoMoreInteractions(listener);
    });
  });
  group('Test Post Stream Widget', () {
    testWidgets('success', (tester) async {
      final postClient = MockPostClient();

      when(() => postClient.getPosts(100))
          .thenAnswer((invocation) async => Future.value(mockPosts));

      await pumpApp(tester, postClient);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(PostCell), findsExactly(2));
    });
    testWidgets('failure', (tester) async {
      final postClient = MockPostClient();
      final exception = Exception('Posts connection failed');
      when(() => postClient.getPosts(100)).thenThrow(exception);

      await pumpApp(tester, postClient);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text(exception.toString()), findsOneWidget);
    });
  });
}
