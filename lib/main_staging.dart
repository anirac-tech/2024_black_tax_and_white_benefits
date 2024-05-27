import 'package:black_tax_and_white_benefits/app/app.dart';
import 'package:black_tax_and_white_benefits/bootstrap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  bootstrap(() => const ProviderScope(child: App()));
}
