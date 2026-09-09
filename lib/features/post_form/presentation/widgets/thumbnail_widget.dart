import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ThumbnailWidget extends StatelessWidget {
  const ThumbnailWidget({
    super.key,
    required this.onTap,
    this.thumbnailImageFile,
    this.thumbnailImageUrl,
    this.cdnUrl,
    this.maxHeight = 300,
    this.aspectRatio,
  });

  final File? thumbnailImageFile;
  final String? thumbnailImageUrl;
  final String? cdnUrl;
  final VoidCallback onTap;
  final double maxHeight;
  final double? aspectRatio;

  @override
  Widget build(BuildContext context) {
    if (thumbnailImageFile == null && thumbnailImageUrl == null) {
      return const SizedBox();
    }

    Widget child = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: thumbnailImageFile != null
          ? Image.file(
              thumbnailImageFile!,
              fit: BoxFit.fitHeight,
            )
          : thumbnailImageUrl != null
              ? CachedNetworkImage(imageUrl: '$cdnUrl/$thumbnailImageUrl')
              : null,
    );

    if (aspectRatio != null) {
      child = AspectRatio(aspectRatio: aspectRatio!, child: child);
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: child,
          ),
          const SizedBox(height: 20),
          const Center(
            child: TextViewWidget(
              text: 'Change media',
              color: colorRed,
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
