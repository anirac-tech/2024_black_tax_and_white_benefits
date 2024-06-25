import 'package:black_tax_and_white_benefits/app/features/posts/data/favorites_repository.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/post_client.dart';
import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post_response.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/post_cell.dart';
import 'package:black_tax_and_white_benefits/app/features/settings/shared_preferences.dart';
import 'package:black_tax_and_white_benefits/app/shared/navigation_icons.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../data/test_data.dart';
import '../helpers/helpers.dart';

class MockPostClient extends Mock implements PostClient {}

const emptyResponse = PostResponse(posts: [], totalPages: 0, totalResults: 0);

void main() {
  ProviderContainer createContainer(PostClient postClient) {
    final container = ProviderContainer(
      overrides: [
        postClientProvider.overrideWithValue(postClient),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  Future<void> pumpApp(WidgetTester tester, PostClient postClient) async {
    final sharedPreferences = MockSharedPreferences();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          postClientProvider.overrideWithValue(postClient),
          favoriteListProvider.overrideWith((ref) => Stream.empty()),
          sharedPreferencesProvider.overrideWith((ref) => Future.value(sharedPreferences)),
        ],
        child: const App(),
      ),
    );
  }

  setUpAll(() {
    registerFallbackValue(const AsyncData<PostResponse>(emptyResponse));
    registerFallbackValue(CancelToken());
  });

  group('Test PostClient and getPosts Provider', () {
    test('success', () async {
      final postClient = MockPostClient();
      when(() => postClient.getPosts(any(), any()))
          .thenAnswer((invocation) => Future.value(mockHttpResponse));

      final container = createContainer(postClient);
      final listener = ProviderListener<AsyncValue<PostResponse>>();

      container.listen<AsyncValue<PostResponse>>(
        getPostsProvider((page: 1)),
        listener.call,
        fireImmediately: true,
      );

      verifyNever(() => listener(null, const AsyncData<PostResponse>(emptyResponse)));

      // Act
      final response = await container.read(getPostsProvider((page: 1)).future);

      // Assert
      verifyInOrder([
        () => listener(null, const AsyncLoading<PostResponse>()),
        () => listener(
              const AsyncLoading<PostResponse>(),
              any(that: isA<AsyncData<PostResponse>>()),
            ),
      ]);

      expect(response.posts.length, mockPosts.length);
    });
    test('failure', () async {
      final postClient = MockPostClient();
      final exception = Exception('Posts connection failed');

      when(() => postClient.getPosts(any(), any())).thenThrow(exception);

      final container = createContainer(postClient);
      final listener = ProviderListener<AsyncValue<PostResponse>>();

      container.listen<AsyncValue<PostResponse>>(
        getPostsProvider((page: 1)),
        listener.call,
        fireImmediately: true,
      );

      const data = AsyncData<PostResponse>(emptyResponse);
      verifyNever(() => listener(null, data));

      await expectLater(
        () async => container.read(getPostsProvider((page: 1)).future),
        throwsA(isA<Exception>()),
      );
      // verify
      verifyInOrder([
        () => listener(null, const AsyncLoading<PostResponse>()),
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
      when(() => postClient.getPosts(any(), any()))
          .thenAnswer((invocation) => Future.value(mockHttpResponse));

      await pumpApp(tester, postClient);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(homeIconKey));
      await tester.pumpAndSettle();

      expect(find.byType(PostCell), findsExactly(mockPosts.length));
    });
    testWidgets('failure', (tester) async {
      final postClient = MockPostClient();
      final exception = Exception('Posts connection failed');
      when(() => postClient.getPosts(any(), any())).thenThrow(exception);

      await pumpApp(tester, postClient);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(homeIconKey));
      await tester.pumpAndSettle();

      expect(find.text(exception.toString()), findsOneWidget);
    });
  });
}
