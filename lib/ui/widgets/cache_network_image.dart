import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class KNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;

  const KNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.fitWidth,
      progressIndicatorBuilder: (context, url, progress) => Center(
        child: CircularProgressIndicator(
          value: progress.progress,
          strokeWidth: 4,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[200],
        child: const Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
