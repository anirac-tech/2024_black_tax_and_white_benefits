import 'package:black_tax_and_white_benefits/app/features/settings/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_startup.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartup(AppStartupRef ref) async {
  ref.onDispose(() {
    ref.invalidate(sharedPreferencesProvider);
  });
  await ref.watch(sharedPreferencesProvider.future);
}

class AppStartupView extends ConsumerWidget {
  const AppStartupView({required this.onLoaded});
  static const String path = '/startup';
  static const String name = 'startup';

  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      loading: () => const AppStartupLoadingView(),
      error: (e, st) => AppStartupErrorView(
        message: e.toString(),
        onRetry: () => ref.invalidate(appStartupProvider),
      ),
      data: (_) => onLoaded(context),
    );
  }
}

class AppStartupLoadingView extends StatelessWidget {
  const AppStartupLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class AppStartupErrorView extends StatelessWidget {
  const AppStartupErrorView({super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
