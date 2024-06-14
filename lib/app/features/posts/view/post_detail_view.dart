import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/favorite_icon_button.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/share_icon_button.dart';
import 'package:black_tax_and_white_benefits/app/features/text_size/text_size_icon_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView(this.post, {super.key, this.bottomSheetHeight = 70});

  final Post post;
  final double bottomSheetHeight;

// coverage:ignore-start
  Future<void> _launchURL(String? url) async {
    if (url == null) return;
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
// coverage:ignore-end

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        actions: <Widget>[
          ShareIconButton(post.link),
          FavoriteIconButton(post),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: bottomSheetHeight),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (post.imageUrl != null)
                CachedNetworkImage(
                  imageUrl: post.imageUrl!,
                  errorWidget: (_, __, ___) => const Icon(Icons.cloud_off),
                  fit: BoxFit.fitWidth,
                ),
              Html(
                data: post.title.rendered,
                style: {'*': Style.fromTextStyle(theme.textTheme.headlineLarge!)},
              ),
              Html(
                // coverage:ignore-start
                data: DateFormat.yMMMMd().format(post.date).toString(),
                // coverage:ignore-end
                style: {'*': Style.fromTextStyle(theme.textTheme.labelLarge!)},
              ),
              Html(
                data: post.content.rendered,
                // coverage:ignore-start
                onLinkTap: (url, attributes, element) => _launchURL(url),
                // coverage:ignore-end
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SafeArea(
        child: SizedBox(
          height: bottomSheetHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Spacer(),
              TextSizeIconButton(increaseSize: false),
              TextSizeIconButton(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
