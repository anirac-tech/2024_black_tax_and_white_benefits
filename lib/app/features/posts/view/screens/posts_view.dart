import 'package:black_tax_and_white_benefits/app/features/posts/view/post_stream_table_view.dart';
import 'package:black_tax_and_white_benefits/app/features/settings/settings_icon_button.dart';
import 'package:black_tax_and_white_benefits/app/features/text_size/adjustable_text_widget.dart';
import 'package:black_tax_and_white_benefits/app/shared/wpa_app_bar.dart';
import 'package:flutter/material.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  // Route information
  static const path = '/posts';
  static const name = 'posts';

  static const pageSize = 10;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: WpaAppBar(
          title: const Text('Black Tax & White Benefits'),
          actions: [SettingsIconButton()],
        ),
        body: AdjustableTextWidget(
          child: Center(
            child: PostStreamTableView(pageSize: pageSize),
          ),
        ),
      );
}
