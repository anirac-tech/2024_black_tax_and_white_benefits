// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBorAqYTXHq9vDuWaFSoR_a58IiKT66hxI',
    appId: '1:485161242483:web:044b2eee89b03dccdbff06',
    messagingSenderId: '485161242483',
    projectId: 'black-tax-white-benefits-8d374',
    authDomain: 'black-tax-white-benefits-8d374.firebaseapp.com',
    storageBucket: 'black-tax-white-benefits-8d374.appspot.com',
    measurementId: 'G-V1R15SE8VC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCexbteOT2a7VRrVrBjTHmo4aHzTBAGzdA',
    appId: '1:485161242483:android:4ed03ed9f13d5200dbff06',
    messagingSenderId: '485161242483',
    projectId: 'black-tax-white-benefits-8d374',
    storageBucket: 'black-tax-white-benefits-8d374.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAB9akSMqa5YSxeYHczH_H0j1xsovumRhY',
    appId: '1:485161242483:ios:d1cdf617b7272844dbff06',
    messagingSenderId: '485161242483',
    projectId: 'black-tax-white-benefits-8d374',
    storageBucket: 'black-tax-white-benefits-8d374.appspot.com',
    iosBundleId: 'com.blacktaxandwhitebenefits.gfapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAB9akSMqa5YSxeYHczH_H0j1xsovumRhY',
    appId: '1:485161242483:ios:afad3490ec965443dbff06',
    messagingSenderId: '485161242483',
    projectId: 'black-tax-white-benefits-8d374',
    storageBucket: 'black-tax-white-benefits-8d374.appspot.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBorAqYTXHq9vDuWaFSoR_a58IiKT66hxI',
    appId: '1:485161242483:web:276ba0ad9c4d10fcdbff06',
    messagingSenderId: '485161242483',
    projectId: 'black-tax-white-benefits-8d374',
    authDomain: 'black-tax-white-benefits-8d374.firebaseapp.com',
    storageBucket: 'black-tax-white-benefits-8d374.appspot.com',
    measurementId: 'G-81KXFLW5DB',
  );
}