import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  AdaptiveAppBar({
    this.title,
    this.actions,
    this.surfaceTintColor,
    this.height = kToolbarHeight,
  });

  final Widget? title;
  final List<Widget>? actions;
  final Color? surfaceTintColor;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: kIsWeb ? false : Platform.isAndroid,
      actions: actions,
      surfaceTintColor: surfaceTintColor,
    );
  }
}
