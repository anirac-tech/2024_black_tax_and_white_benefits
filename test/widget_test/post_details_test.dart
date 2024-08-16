import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/screens/posts_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/test_data.dart';
import '../helpers/helpers.dart';

void main() {
  group('Test Detail view', () {
    testWidgets('launch url', (tester) async {
      // Load app widget.
      await tester.pumpApp(const App());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('${PostsView.name}_${mockPosts.first.id}')));
      await tester.pumpAndSettle();

      await tester.tapOnText(find.textRange
          .ofSubstring('In my last blog article, I described God’s obvious love of great variety'));

      // Exit Details screen
      await tester.pageBack();
      await tester.pumpAndSettle();
    });
    testWidgets('share', (tester) async {
      // Load app widget.
      await tester.pumpApp(const App());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key('${PostsView.name}_${mockPosts.first.id}')));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.share));
      await tester.pumpAndSettle();

      // Exit Details screen
      await tester.pageBack();
      await tester.pumpAndSettle();
    });
  });
}
