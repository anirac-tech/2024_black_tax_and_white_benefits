import 'package:black_tax_and_white_benefits/app/features/settings/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'text_size_controller.g.dart';

@Riverpod(keepAlive: true)
class TextSizeController extends _$TextSizeController {
  double build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.valueOrNull?.getDouble(textSizeKey) ?? 1.0;
  }

  static const String textSizeKey = 'textSize';

  Future<void> _storeState() async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs.hasValue) {
      await prefs.value!.setDouble(textSizeKey, state);
    }
  }

  void increase() {
    state *= 1.28;
    _storeState();
  }

  void decrease() {
    state *= 0.78125;
    _storeState();
  }
}