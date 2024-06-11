import 'package:black_tax_and_white_benefits/app/features/posts/data/post_client.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/post_cell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Black Tax White Benefits')),
        body: Center(
          child: Consumer(
            builder: (context, ref, child) {
              final posts = ref.watch(getPostsProvider);
              debugPrint(posts.valueOrNull?.map((e) => '${e.id}').toString());

              return posts.when(
                data: (data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final post = data[index];
                    return PostCell(
                      post,
                      onTap: () => context.pushNamed("details", extra: post),
                    );
                  },
                ),
                loading: () => const CircularProgressIndicator.adaptive(),
                error: (error, stackTrace) => Text(error.toString()),
              );
            },
          ),
        ),
      );
}
