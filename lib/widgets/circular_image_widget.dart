import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/consts/color.dart';

class CircularImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? radius;

  const CircularImageWidget({super.key, this.imageUrl, this.radius = 28});

  @override
  Widget build(BuildContext context) {
    if (imageUrl?.startsWith('http') ?? true) {
      return CircleAvatar(
        radius: radius,
        child: CachedNetworkImage(
          imageUrl: '$imageUrl',
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: colorBlackSemiTransparent,
            highlightColor: colorTransparent,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
          errorWidget: (context, url, error) {
            return Container(
              decoration: BoxDecoration(
                color: colorBlack1A,
                shape: BoxShape.circle,
              ),
            );
          },
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            );
          },
        ),
      );
    }

    return CircleAvatar(
      radius: radius,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: FileImage(File(imageUrl!)),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
