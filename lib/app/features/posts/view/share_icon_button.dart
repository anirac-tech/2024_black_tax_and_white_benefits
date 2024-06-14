import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareIconButton extends StatelessWidget {
  const ShareIconButton(this.link, {super.key});

  final String link;

  Future<void> _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      'Look at this blog post from Black Tax White Benefits: $link!',
      subject: 'Check out this Blog Post',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => _onShare(context),
        icon: const Icon(Icons.share),
      );
}
