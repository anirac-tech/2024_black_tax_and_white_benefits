import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:black_tax_and_white_benefits/app/config/logger.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/post_client.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/post_cell.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/post_stream_table_view.dart';
import 'package:black_tax_and_white_benefits/app/shared/navigation_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';

import 'helpers/screenshot.dart';

Future<void> main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'Screenshots',
    () {
      testWidgets('posts stream view', (tester) async {
        final name = 'posts_view';

        await tester.pumpWidget(ProviderScope(child: const App()));
        await tester.pumpAndSettle();

        expect(find.byType(PostCell), findsAny);
        // Wait for cached images to load
        await tester.pump(Duration(seconds: 1));

        await takeScreenShot(binding: binding, tester: tester, screenShotName: name);
        await tester.pumpAndSettle();

        Log.d('Screenshot Taken: $name');
      });
      testWidgets('posts detail view', (tester) async {
        final name = 'posts_detail_view';

        await tester.pumpWidget(ProviderScope(child: const App()));
        await tester.pumpAndSettle();

        expect(find.byType(PostCell), findsAny);
        // Wait for cached images to load

        final element = tester.element(find.byType(PostStreamTableView));
        final container = ProviderScope.containerOf(element);

        final response = await container.read(getPostsProvider((page: 1)).future);
        await tester.tap(find.text(response.posts.first.title.rendered));
        await tester.pumpAndSettle();

        await takeScreenShot(binding: binding, tester: tester, screenShotName: name);
        await tester.pumpAndSettle();

        Log.d('Screenshot Taken: $name');

        // Exit Details screen
        await tester.pageBack();
        await tester.pumpAndSettle();
      });
      testWidgets('posts detail view', (tester) async {
        final name = 'favorites_view';

        await tester.pumpWidget(ProviderScope(child: const App()));
        await tester.pumpAndSettle();

        expect(find.byType(PostCell), findsAny);
        // Wait for cached images to load

        final element = tester.element(find.byType(PostStreamTableView));
        final container = ProviderScope.containerOf(element);

        final response = await container.read(getPostsProvider((page: 1)).future);
        await tester.tap(find.text(response.posts[1].title.rendered));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.favorite_outline));
        await tester.pumpAndSettle();

        // Exit Details screen
        await tester.pageBack();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(favoritesIconKey));
        await tester.pumpAndSettle();

        await takeScreenShot(binding: binding, tester: tester, screenShotName: name);
        await tester.pumpAndSettle();

        Log.d('Screenshot Taken: $name');
      });
    },
  );
}