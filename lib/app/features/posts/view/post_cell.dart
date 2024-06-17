import 'package:black_tax_and_white_benefits/app/features/posts/domain/post.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/favorite_icon_button.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/share_icon_button.dart';
import 'package:black_tax_and_white_benefits/app/features/posts/view/wpa_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class PostCell extends StatelessWidget {
  const PostCell(this.post, {this.onTap, super.key});

  final Post post;
  final VoidCallback? onTap;

  static const double _kMaxTextScaleFactor = 1.7;

  @override
  Widget build(BuildContext context) => MediaQuery.withClampedTextScaling(
        maxScaleFactor: _kMaxTextScaleFactor,
        child: Card(
          shadowColor: Colors.transparent,
          child: ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Html(
                    data: post.title.rendered,
                    style: {
                      '*': Style(
                        fontWeight: FontWeight.w600,
                        maxLines: 4,
                        textOverflow: TextOverflow.ellipsis,
                      )
                    },
                  ),
                ),
                post.imageUrl != null
                    ? Container(
                        padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                        alignment: Alignment.topLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: SizedBox(
                            height: 60,
                            width: 80,
                            child: FittedBox(
                              clipBehavior: Clip.hardEdge,
                              fit: BoxFit.fitWidth,
                              child: WpaImage(post.imageUrl!),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            subtitle: Column(
              children: [
                Html(
                  data: post.excerpt.rendered,
                  style: {
                    '*': Style(
                      maxLines: 3,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  },
                ),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: Html(
                          data: DateFormat.yMMMd().format(post.date).toString(),
                          shrinkWrap: true,
                          style: {'*': Style(fontWeight: FontWeight.w200)},
                        ),
                      ),
                      ShareIconButton(post.link),
                      FavoriteIconButton(post),
                    ],
                  ),
                ),
              ],
            ),
            onTap: onTap,
          ),
        ),
      );
}
