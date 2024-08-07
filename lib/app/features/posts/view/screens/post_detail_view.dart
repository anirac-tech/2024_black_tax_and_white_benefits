import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/favorite_icon_button.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/share_icon_button.dart';
import 'package:black_tax_and_white_benefits/app/shared/wpa_app_bar.dart';
import 'package:black_tax_and_white_benefits/app/shared/error_snackbar_view.dart';
import 'package:black_tax_and_white_benefits/app/shared/wpa_image.dart';
import 'package:black_tax_and_white_benefits/app/features/text_size/adjustable_text_widget.dart';
import 'package:black_tax_and_white_benefits/app/features/text_size/text_size_icon_button.dart';
import 'package:black_tax_and_white_benefits/app/shared/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class PostDetailView extends HookConsumerWidget {
  const PostDetailView(this.post, {super.key, this.bottomSheetHeight = 70});

  // Route information
  static const path = '/details';
  static const name = 'details';

  final Post post;
  final double bottomSheetHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final _url = useState(null as String?);

    return ErrorSnackbarView(
      provider: launchProvider(url: _url.value),
      child: Scaffold(
        appBar: WpaAppBar(
          title: const Text('Post Details'),
          actions: <Widget>[
            ShareIconButton(post),
            FavoriteIconButton(post),
          ],
        ),
        body: AdjustableTextWidget(
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomSheetHeight),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (post.imageUrl != null)
                    WpaImage(
                      post.imageUrl!,
                      fit: BoxFit.fitWidth,
                    ),
                  Html(
                    data: post.title.rendered,
                    style: {'*': Style.fromTextStyle(theme.textTheme.headlineLarge!)},
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat.yMMMMd().format(post.date).toString(),
                      style: theme.textTheme.labelLarge!,
                    ),
                  ),
                  Html(
                    data: post.content.rendered,
                    onLinkTap: (url, _, __) =>
                        (url == _url.value) ? ref.invalidate(launchProvider) : _url.value = url,
                  ),
                ],
              ),
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
                TextSizeIconButton(isIncrease: false),
                TextSizeIconButton(),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
