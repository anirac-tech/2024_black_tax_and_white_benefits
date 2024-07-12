// coverage:ignore-file
import 'package:black_tax_and_white_benefits/app/config/flavor.dart';
import 'package:black_tax_and_white_benefits/app/config/logger.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'log_manager.g.dart';

class LogManager {
  const LogManager({
    required this.crashlytics,
    required this.analytics,
    required this.logger,
  });

  final FirebaseCrashlytics? crashlytics;
  final FirebaseAnalytics? analytics;
  final Logger logger;

  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    await analytics?.logEvent(name: name, parameters: parameters, callOptions: callOptions);
    logger.d('[${analytics != null ? 'Firebase' : 'Event'}] Sent $name with params $parameters');
  }

  Future<void> logAppOpen(String? appFlavor) async {
    await analytics?.logAppOpen(parameters: {'flavor': '$appFlavor'});
    logger.d('appFlavor=$appFlavor');
  }

  Future<void> logShare({required Post post, required ShareResult shareResult}) async {
    await analytics?.logShare(
      contentType: 'post',
      itemId: '${post.id}',
      method: 'icon',
      parameters: {'status': '${shareResult.status.name}'},
    );
    logger.d('''[${analytics != null ? 'Firebase' : 'Event'}] 
        Shared post ${post.id} with status ${shareResult.status.name}''');
  }

  Future<void> d(String message) async {
    logger.d(message);
    await crashlytics?.log(message);
  }

  Future<void> e(
    String message,
    Object error, {
    StackTrace? stackTrace,
    bool isFatal = false,
  }) async {
    await crashlytics?.recordError(error, stackTrace, fatal: isFatal);
    logger.e(message, error: error, stackTrace: stackTrace);
  }
}

@Riverpod(keepAlive: true)
FutureOr<FirebaseAnalytics> analytics(AnalyticsRef ref) => FirebaseAnalytics.instance;

@Riverpod(keepAlive: true)
FutureOr<FirebaseCrashlytics> crashlytics(CrashlyticsRef ref) => FirebaseCrashlytics.instance;

@Riverpod(keepAlive: true)
LogManager logManager(LogManagerRef ref) {
  final analytics = ref.watch(analyticsProvider);
  final crashlytics = ref.watch(crashlyticsProvider);
  final appFlavor = getFlavor();
  final logger = (appFlavor == Flavor.prod) ? Log.prodLogger : Log.logger;
  return LogManager(
      analytics: analytics.valueOrNull, crashlytics: crashlytics.valueOrNull, logger: logger);
}
