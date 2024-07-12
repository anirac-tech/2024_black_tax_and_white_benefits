import 'dart:async';

import 'package:black_tax_and_white_benefits/app/config/initialize_firebase.dart';
import 'package:black_tax_and_white_benefits/app/config/logger.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeFirebaseApp();

  FlutterError.onError = (details) {
    Log.e(
      details.exceptionAsString(),
      details.exception,
      stackTrace: details.stack,
    );
    FirebaseCrashlytics.instance.recordFlutterError(details);
  };

  FirebaseAnalytics.instance.logAppOpen(parameters: {'app_flavor': '$appFlavor'});

  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  initializeDateFormatting();

  runApp(ProviderScope(child: await builder()));
}
