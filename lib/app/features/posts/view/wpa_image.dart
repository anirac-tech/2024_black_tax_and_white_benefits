import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WpaImage extends StatelessWidget {
  const WpaImage(this.imageUrl, {super.key, this.fit});

  final String imageUrl;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: imageUrl,
        // coverage:ignore-start
        errorWidget: (_, __, ___) => const Icon(Icons.cloud_off),
        // coverage:ignore-end
        fit: fit,
      );
}
