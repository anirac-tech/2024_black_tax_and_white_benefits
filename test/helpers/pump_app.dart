import 'package:black_tax_and_white_benefits/app/features/posts/data/favorites_repository.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/post_client.dart';
import 'package:black_tax_and_white_benefits/app/features/settings/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/test_data.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {
  final Map<String, double?> data = Map<String, double?>();

  @override
  double? getDouble(String key) {
    return data.containsKey(key) ? data[key] : null;
  }

  @override
  Future<bool> setDouble(String key, double value) {
    data[key] = value;
    return Future.value(true);
  }
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget, {List<Override>? overrides}) {
    final sharedPreferences = MockSharedPreferences();

    return pumpWidget(
      ProviderScope(
        overrides: [
          getPostsProvider.overrideWith((ref) async => Future.value(mockPostResponse)),
          favoriteListProvider.overrideWith((ref) => Stream.value(mockPosts)),
          sharedPreferencesProvider.overrideWith((ref) => Future.value(sharedPreferences)),
          if (overrides != null) ...overrides,
        ],
        child: widget,
      ),
    );
  }
}
