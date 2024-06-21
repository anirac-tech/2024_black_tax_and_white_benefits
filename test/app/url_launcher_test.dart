import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:black_tax_and_white_benefits/app/shared/navigation_icons.dart';
import 'package:black_tax_and_white_benefits/app/shared/url_launcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../helpers/helpers.dart';

void main() {
  group('Test Launch URL', () {
    testWidgets('error', (tester) async {
      final exception = Exception('Could not launch url');
      final urlLauncher = MockUrlLauncher();
      when(() => urlLauncher.launch(any())).thenAnswer(
        (invocation) async {
          urlLauncher.state = AsyncError(exception, StackTrace.current);
          return;
        },
      );
      // Load app widget.
      await tester.pumpApp(
        const App(),
        overrides: [urlLauncherProvider.overrideWith(() => urlLauncher)],
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(aboutIconKey));
      await tester.pumpAndSettle();

      await tester.tapOnText(find.textRange.ofSubstring('Contact'));
      await tester.pumpAndSettle();

      expect(find.text(exception.toString()), findsOneWidget);
    });
  });
}
