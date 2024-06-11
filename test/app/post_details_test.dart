import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  group('Test Detail view', () {
    testWidgets('launch url', (tester) async {
      // Load app widget.
      await tester.pumpApp(const App());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Black Tax'));
      await tester.pumpAndSettle();

      await tester.tapOnText(find.textRange
          .ofSubstring('In my last blog article, I described God’s obvious love of great variety'));

      // Exit Details screen
      await tester.pageBack();
      await tester.pumpAndSettle();
    });
  });
}
