import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('', (tester) async {
    await tester.pumpWidget(ProviderScope(child: const App()));
    await tester.pumpAndSettle();
  });
}
