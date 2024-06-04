import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/post_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('Test widgets', (tester) async {
    // Load app widget.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          getPostsProvider.overrideWith((ref) async {
            return Future.value([]);
          }),
        ],
        child: const App(),
      ),
    );

    expect(find.text('Black Tax White Benefits'), findsOneWidget);
  });
}
