// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$analyticsHash() => r'380e1e5ed14c10a7f2f757d37674035e08567ebc';

/// See also [analytics].
@ProviderFor(analytics)
final analyticsProvider = FutureProvider<FirebaseAnalytics>.internal(
  analytics,
  name: r'analyticsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$analyticsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AnalyticsRef = FutureProviderRef<FirebaseAnalytics>;
String _$crashlyticsHash() => r'8b66fe93169497fdd6ae235f819d3c4b7d69c006';

/// See also [crashlytics].
@ProviderFor(crashlytics)
final crashlyticsProvider = FutureProvider<FirebaseCrashlytics>.internal(
  crashlytics,
  name: r'crashlyticsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$crashlyticsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CrashlyticsRef = FutureProviderRef<FirebaseCrashlytics>;
String _$logManagerHash() => r'11fba30f58c18982817c5a5e95a663b7e04f0914';

/// See also [logManager].
@ProviderFor(logManager)
final logManagerProvider = Provider<LogManager>.internal(
  logManager,
  name: r'logManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$logManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LogManagerRef = ProviderRef<LogManager>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
