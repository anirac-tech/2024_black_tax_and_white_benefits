import 'package:black_tax_and_white_benefits/env/flavor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:black_tax_and_white_benefits/firebase_options.dart' as prod;
import 'package:black_tax_and_white_benefits/firebase_options_dev.dart' as dev;

Future<void> initializeFirebaseApp() async {
  final firebaseOptions = switch (getFlavor()) {
    Flavor.prod => prod.DefaultFirebaseOptions.currentPlatform,
    Flavor.stg => dev.DefaultFirebaseOptions.currentPlatform,
    Flavor.dev => dev.DefaultFirebaseOptions.currentPlatform,
  };
  await Firebase.initializeApp(
    options: firebaseOptions,
  );
}
