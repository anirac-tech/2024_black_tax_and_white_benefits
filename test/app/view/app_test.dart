import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Test Screen Visibility', () {
    testWidgets('Home', (tester) async {
      // Load app widget.
      await tester.pumpApp(const App());

      await tester.tap(find.byIcon(Icons.home));

      expect(find.text('Black Tax White Benefits'), findsOneWidget);
    });
    testWidgets('Favorites', (tester) async {
      // Load app widget.
      await tester.pumpApp(const App());

      await tester.tap(find.byIcon(Icons.favorite));

      expect(find.text('Favorites'), findsAny);
    });
    testWidgets('Detail', (tester) async {
      // Load app widget.
      await tester.pumpApp(const App());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Black Tax'));
      await tester.pumpAndSettle();

      expect(find.text('Post Details'), findsOneWidget);

      // Exit Details screen
      await tester.pageBack();
      await tester.pumpAndSettle();
    });
  });
  group('Smaller Device', () {
    testWidgets("navigation", (tester) async {
      tester.view.physicalSize = Size(300, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpApp(const App());
      // View Home Screen
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      expect(find.text('Black Tax White Benefits'), findsOneWidget);

      // View Favorites screen
      await tester.tap(find.byIcon(Icons.favorite));

      expect(find.text('Favorites'), findsAny);
    });
  });
}
