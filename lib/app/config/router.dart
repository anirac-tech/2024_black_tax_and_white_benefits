import 'package:black_tax_and_white_benefits/app/app_startup.dart';
import 'package:black_tax_and_white_benefits/app/shared/home_screen.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/favorites_view.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/post_detail_view.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/posts_view.dart';
import 'package:black_tax_and_white_benefits/app/features/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final appStartupState = ref.watch(appStartupProvider);
  return GoRouter(
    initialLocation: PostsView.path,
    // * Passing a navigatorKey causes an issue on hot reload:
    // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
    // * However it's still necessary otherwise the navigator pops back to
    // * root on hot reload
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // If the app is still initializing, show the /startup route
      if (appStartupState.isLoading || appStartupState.hasError) {
        return AppStartupView.path;
      }

      final path = state.uri.path;

      if (path.startsWith(AppStartupView.path)) {
        return PostsView.path;
      }

      return null;
    },
    routes: [
      // Stateful navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        builder: (_, __, navigationShell) {
          return HomeScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              // Posts View
              GoRoute(
                path: PostsView.path,
                name: PostsView.name,
                pageBuilder: (_, __) => const NoTransitionPage(
                  child: PostsView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              // Favorites View
              GoRoute(
                path: FavoritesView.path,
                name: FavoritesView.name,
                pageBuilder: (_, __) => const NoTransitionPage(
                  child: FavoritesView(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: PostDetailView.path,
        name: PostDetailView.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) {
          Post post = state.extra as Post;
          return PostDetailView(post);
        },
      ),
      GoRoute(
        path: SettingsView.path,
        name: SettingsView.name,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, __) => SettingsView(),
      ),
      GoRoute(
        path: AppStartupView.path,
        name: AppStartupView.name,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => NoTransitionPage(
          child: AppStartupView(
            onLoaded: (_) => const SizedBox.shrink(),
          ),
        ),
      ),
    ],
  );
}
