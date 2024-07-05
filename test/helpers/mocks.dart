import 'dart:async';

import 'package:black_tax_and_white_benefits/app/config/analytics.dart';
import 'package:black_tax_and_white_benefits/app/config/logger.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/database/database.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/post_client.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:firebase_analytics_platform_interface/src/analytics_call_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:mocktail/mocktail.dart';
import 'package:share_plus_platform_interface/platform_interface/share_plus_platform.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockPostClient extends Mock implements PostClient {}

class MockAnalytics extends Mock implements Analytics {
  @override
  Future<void> logEvent(
      {required String name,
      Map<String, Object>? parameters,
      AnalyticsCallOptions? callOptions}) async {
    Log.d('Event $name triggered with params $parameters');
  }

  @override
  Future<void> logShare({required Post post, required ShareResult shareResult}) async {
    Log.d('Shared ${post.id} with result ${shareResult.status}');
  }
}

class MockCrashlytics extends Mock implements FirebaseCrashlytics {
  @override
  Future<void> recordError(exception, StackTrace? stack,
      {reason,
      Iterable<Object> information = const [],
      bool? printDetails,
      bool fatal = false}) async {}
}

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

class MockDatabase extends Mock implements WpaDatabase {
  final List<FavoritePost> favorites = List.empty(growable: true);
  final StreamController<List<FavoritePost>> favoritesController =
      StreamController<List<FavoritePost>>();

  MockDatabase() {
    favorites.clear();
    favoritesController.add(favorites);
  }

  @override
  Stream<List<FavoritePost>> watchPosts() => favoritesController.stream;
  @override
  Future<List<FavoritePost>> getPosts() => Future.value(favorites);

  void add(FavoritePost post) {
    favorites.add(post);
    favoritesController.add(favorites);
  }

  void remove(FavoritePost post) {
    favorites.remove(post);
    favoritesController.add(favorites);
  }

  @override
  Future<void> close() async {
    await favoritesController.close();
    reset(this);
  }
}
