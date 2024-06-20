import 'dart:async';

import 'package:black_tax_and_white_benefits/app/config/logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    Log.e(details.exceptionAsString(), details.exception, stackTrace: details.stack);
  };

  Log.d('appFlavor=$appFlavor');

  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  initializeDateFormatting();

  runApp(ProviderScope(child: await builder()));
}
