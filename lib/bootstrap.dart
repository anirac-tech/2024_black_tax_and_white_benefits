import 'dart:async';

import 'package:black_tax_and_white_benefits/app/config/analytics.dart';
import 'package:black_tax_and_white_benefits/app/config/logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (details) {
    Log.e(
      details.exceptionAsString(),
      details.exception,
      stackTrace: details.stack,
      crashlytics: FirebaseCrashlytics.instance,
    );
  };

  Analytics().logAppOpen(appFlavor);

  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  initializeDateFormatting();

  runApp(ProviderScope(child: await builder()));
}
