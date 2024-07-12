import 'package:black_tax_and_white_benefits/env/flavor.dart';
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
  await Firebase.initializeApp(
    name: 'btwb${flavor == Flavor.prod ? '' : ' ${flavor.name}'}',
    options: firebaseOptions,
  );
}
