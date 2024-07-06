// coverage:ignore-file

import 'package:black_tax_and_white_benefits/app/config/logger.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'analytics.g.dart';

class Analytics {
  final _analytics = FirebaseAnalytics.instance;

  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    await _analytics.logEvent(name: name, parameters: parameters, callOptions: callOptions);
    Log.d('[Firebase] Sent $name with params $parameters');
  }

  Future<void> logAppOpen(String? appFlavor) async {
    await _analytics.logAppOpen(parameters: {'flavor': '$appFlavor'});
    Log.d('appFlavor=$appFlavor');
  }

  Future<void> logShare({required Post post, required ShareResult shareResult}) async {
    await _analytics.logShare(
      contentType: 'post',
      itemId: '${post.id}',
      method: 'icon',
      parameters: {'status': '${shareResult.status.name}'},
    );
    Log.d('[Firebase] Shared post ${post.id} with status ${shareResult.status.name}');
  }
}

@Riverpod(keepAlive: true)
Analytics analytics(AnalyticsRef ref) => Analytics();

@Riverpod(keepAlive: true)
FirebaseCrashlytics crashlytics(CrashlyticsRef ref) => FirebaseCrashlytics.instance;
