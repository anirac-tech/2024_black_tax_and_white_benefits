import 'package:black_tax_and_white_benefits/app/domain/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PostCell extends StatelessWidget {
  const PostCell(this.post, {super.key});

  final Post post;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Html(data: post.title.rendered),
        subtitle: Html(data: post.excerpt?.rendered ?? ''),
      );
}
