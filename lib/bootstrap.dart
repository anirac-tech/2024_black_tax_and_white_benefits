import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  debugPrint('appFlavor=$appFlavor');

  runApp(await builder());
}
