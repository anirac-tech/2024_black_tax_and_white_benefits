import 'package:black_tax_and_white_benefits/app/config/analytics.dart';
import 'package:black_tax_and_white_benefits/app/config/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends ConsumerWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data});
  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final crashlytics = ref.watch(crashlyticsProvider);
    return value.when(
      data: data,
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      error: (e, _) {
        Log.e(e.toString(), e, crashlytics: crashlytics);
        return Center(
          child: Text(e.toString(),
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.error,
              )),
        );
      },
    );
  }
}
