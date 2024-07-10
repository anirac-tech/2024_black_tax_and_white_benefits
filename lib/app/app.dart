import 'package:black_tax_and_white_benefits/app/config/router.dart';
import 'package:black_tax_and_white_benefits/app/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final theme = ref.watch(themeProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: theme.lightPlatform,
      darkTheme: theme.darkPlatform,
      themeMode: ThemeMode.system,
    );
  }
}
