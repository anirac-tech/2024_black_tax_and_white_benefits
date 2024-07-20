import 'package:black_tax_and_white_benefits/app/config/logger.dart';
import 'package:black_tax_and_white_benefits/env/flavor.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:black_tax_and_white_benefits/firebase_options.dart' as prod;
import 'package:black_tax_and_white_benefits/firebase_options_stg.dart' as stg;
import 'package:black_tax_and_white_benefits/firebase_options_dev.dart' as dev;

Future<void> initializeFirebaseApp() async {
  final flavor = getFlavor();
  final firebaseOptions = switch (flavor) {
    Flavor.prod => prod.DefaultFirebaseOptions.currentPlatform,
    Flavor.stg => stg.DefaultFirebaseOptions.currentPlatform,
    Flavor.dev => dev.DefaultFirebaseOptions.currentPlatform,
  };

  try {
    await Firebase.initializeApp(options: firebaseOptions);
    await FirebaseAnalytics.instance.logAppOpen(parameters: {'app_flavor': '${flavor.name}'});
  } catch (e) {
    Log.e(e.toString(), e);
  }
}
