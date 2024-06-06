import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/favorite_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView(this.post, {super.key});

  final Post post;

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
          IconButton(onPressed: null, icon: Icon(Icons.share)),
          FavoriteIconButton(post),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Html(
                data: post.title.rendered,
                style: {'*': Style.fromTextStyle(theme.textTheme.headlineLarge!)},
              ),
              Html(
                // coverage:ignore-start
                data: post.date != null
                    ? DateFormat.yMMMMd().format(DateTime.parse(post.date!)).toString()
                    : 'N.D.',
                // coverage:ignore-end
                style: {'*': Style.fromTextStyle(theme.textTheme.labelLarge!)},
              ),
              if (post.content != null)
                Html(
                  data: post.content!.rendered,
                  // coverage:ignore-start
                  onLinkTap: (url, attributes, element) => _launchURL(url),
                  // coverage:ignore-end
                ),
            ],
          ),
        ),
      ),
    );
  }
}
