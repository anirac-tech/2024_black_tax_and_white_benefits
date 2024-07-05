import 'package:black_tax_and_white_benefits/app/config/analytics.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class ShareIconButton extends ConsumerWidget {
  const ShareIconButton(this.post, {super.key});

  final Post post;

  Future<void> _onShare(BuildContext context, Analytics analytics) async {
    final box = context.findRenderObject() as RenderBox?;

    final ShareResult shareResult = await Share.share(
      'Look at this blog post from Black Tax & White Benefits by Gordon Ferguson: ${post.link}!',
      subject: 'Check out this Blog Post',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );

    // coverage:ignore-start
    analytics.logShare(
      post: post,
      shareResult: shareResult,
    );
    // coverage:ignore-end
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => IconButton(
        onPressed: () => _onShare(context, ref.read(analyticsProvider)),
        icon: const Icon(Icons.share),
      );
}
