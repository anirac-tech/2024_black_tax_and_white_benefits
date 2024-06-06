import 'package:black_tax_and_white_benefits/app/features/posts/data/favorites_repository.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/post_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/test_data.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      ProviderScope(
        overrides: [
          getPostsProvider.overrideWith((ref) async => Future.value(mockPosts)),
          favoriteListProvider.overrideWith((ref) => Stream.value(mockPosts)),
        ],
        child: widget,
      ),
    );
  }
}
