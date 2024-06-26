import 'dart:io';

import 'package:black_tax_and_white_benefits/app/config/logger.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/data/post_client.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post_response.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/post_cell.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/post_detail_view.dart';
import 'package:black_tax_and_white_benefits/app/features/settings/settings_icon_button.dart';
import 'package:black_tax_and_white_benefits/app/features/text_size/adjustable_text_widget.dart';
import 'package:black_tax_and_white_benefits/app/shared/async_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  // Route information
  static const path = '/posts';
  static const name = 'posts';

  static const pageSize = 10;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const Text('Black Tax White Benefits'),
            centerTitle: Platform.isAndroid,
            actions: [SettingsIconButton()]),
        body: AdjustableTextWidget(
          child: Center(
            child: Consumer(
              builder: (context, ref, child) {
                final responseAsync = ref.watch(getPostsProvider((page: 1)));
                final posts = responseAsync.valueOrNull?.posts;
                Log.d("[Post Stream] ${posts?.map((e) => '${e.id}')}");

                return RefreshIndicator.adaptive(
                  onRefresh: () async {
                    ref.invalidate(getPostsProvider);
                    try {
                      await ref.read(
                        getPostsProvider((page: 1)).future,
                      );
                    } catch (e) {}
                  },
                  child: AsyncValueWidget<PostResponse>(
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
                            return PostCell(
                              post,
                              onTap: () => context.pushNamed(PostDetailView.name, extra: post),
                            );
                          },
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 10),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
}
