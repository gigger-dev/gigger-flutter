import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void showImageViewer(
  BuildContext context, {
  required String url,
}) {
  showDialog(
    context: context,
    builder: (context) => ImageViewer(url: url),
  );
}

class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PhotoView(
          maxScale: PhotoViewComputedScale.contained * 1.2,
          minScale: PhotoViewComputedScale.contained,
          initialScale: PhotoViewComputedScale.contained,
          imageProvider: CachedNetworkImageProvider(url),
          heroAttributes: PhotoViewHeroAttributes(tag: Key(url)),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: BackButton(),
        ),
      ],
    );
  }
}
