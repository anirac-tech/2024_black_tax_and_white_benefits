import 'package:black_tax_and_white_benefits/app/config/log_manager.dart';
import 'package:black_tax_and_white_benefits/app/config/theme.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/post_client.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post_response.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/post_cell.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/screens/post_detail_view.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/screens/posts_view.dart';
import 'package:black_tax_and_white_benefits/app/shared/async_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostStreamTableView extends ConsumerWidget {
  PostStreamTableView({super.key, required this.pageSize});

  final int pageSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responseAsync = ref.watch(getPostsProvider((page: 1)));
    final posts = responseAsync.valueOrNull?.posts;
    final log = ref.watch(logManagerProvider);
    final theme = Theme.of(context);
    log.d("[Post Stream] ${posts?.map((e) => '${e.id}')}");

    return AsyncValueWidget<PostResponse>(
      value: responseAsync,
      data: (data) => ListView.separated(
        itemCount: data.totalResults,
        itemBuilder: (context, index) {
          final page = index ~/ pageSize + 1;
          final indexInPage = index % pageSize;
          final responseAsync = ref.watch(
            getPostsProvider((page: page)),
          );

          return responseAsync.when(
            error: (err, stack) => PostCellError(
              page: page,
              indexInPage: indexInPage,
              error: err.toString(),
              isLoading: responseAsync.isLoading,
            ),
            loading: () => const PostCellLoading(),
            data: (data) {
              if (indexInPage >= data.posts.length) {
                return null;
              }
              final post = data.posts[indexInPage];
              if (index == 0 && post.imageUrl != null) {
                return PostCellFeatured(
                  post,
                  key: Key('${PostsView.name}_${post.id}'),
                  routeName: PostsView.name,
                  onTap: () => context.pushNamed(PostDetailView.name, extra: post),
                );
              } else {
                if (post.id == 58) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                        child: Text(
                          'In order',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      PostCell(
                        post,
                        key: Key('${PostsView.name}_${post.id}'),
                        routeName: PostsView.name,
                        onTap: () => context.pushNamed(PostDetailView.name, extra: post),
                      ),
                    ],
                  );
                }
                return PostCell(
                  post,
                  key: Key('${PostsView.name}_${post.id}'),
                  routeName: PostsView.name,
                  onTap: () => context.pushNamed(PostDetailView.name, extra: post),
                );
              }
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
