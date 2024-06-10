import 'package:black_tax_and_white_benefits/app/config/home_screen.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/favorites_view.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/post_detail_view.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/posts_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

final goRouter = GoRouter(
  initialLocation: '/posts',
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
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
            GoRoute(
              path: '/posts',
              pageBuilder: (_, __) => const NoTransitionPage(
                child: PostsView(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/favorites',
              pageBuilder: (_, __) => const NoTransitionPage(
                child: FavoritesView(),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/details',
      name: 'details',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, state) {
        Post post = state.extra as Post;
        return PostDetailView(post);
      },
    )
  ],
);
