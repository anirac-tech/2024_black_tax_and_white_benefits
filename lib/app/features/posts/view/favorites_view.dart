import 'package:black_tax_and_white_benefits/app/features/posts/data/favorites_repository.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/post_cell.dart';
import 'package:black_tax_and_white_benefits/app/features/settings/settings_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Favorites'), actions: [SettingsIconButton()]),
        body: Center(
          child: Consumer(
            builder: (context, ref, child) {
              final posts = ref.watch(favoriteListProvider);
              debugPrint("[Favorites Stream] ${posts.valueOrNull?.map((e) => '${e.id}')}");

              return posts.when(
                data: (data) => data.isNotEmpty
                    ? ListView.separated(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final post = data[index];
                          return PostCell(
                            post,
                            onTap: () => context.pushNamed("details", extra: post),
                          );
                        },
                        separatorBuilder: (_, __) => SizedBox(height: 10),
                      )
                    : const Text('You have nothing in your favorites.'),
                loading: () => const CircularProgressIndicator.adaptive(),
                error: (error, stackTrace) => Text(error.toString()),
              );
            },
          ),
        ),
      );
}
