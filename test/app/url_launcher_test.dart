import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:black_tax_and_white_benefits/app/shared/navigation_icons.dart';
import 'package:black_tax_and_white_benefits/app/shared/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('Test Launch URL', () {
    testWidgets('error', (tester) async {
      final exception = Exception('Could not launch url');
      // Load app widget.
      await tester.pumpApp(const App(), overrides: [
        launchProvider.overrideWith((_) => throw (exception)),
      ]);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(aboutIconKey));
      await tester.pumpAndSettle();

      // For some reason double-tapping is required
      await tester.tapOnText(find.textRange.ofSubstring('Contact'));
      await tester.tapOnText(find.textRange.ofSubstring('Contact'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(exception.toString()), findsOneWidget);
    });
  });
}
