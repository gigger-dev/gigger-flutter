import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/consts/color.dart';

class CoverImageWidget extends StatelessWidget {
  const CoverImageWidget({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
  });

  final String? url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (url?.startsWith('http') ?? true) {
      return SizedBox(
        width: 1.sw,
        height: 0.65.sh,
        child: CachedNetworkImage(
          imageUrl: '$url',
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
          errorWidget: (context, url, error) => Container(
            color: colorBlack1A,
            alignment: Alignment.center,
            child: TextViewWidget(
              text: 'Image not found',
              color: colorWhite,
            ),
          ),
          fit: fit,
        ),
      );
    }

    return Container(
      width: 1.sw,
      height: 0.65.sh,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(File('$url')),
          fit: fit,
        ),
      ),
    );
  }
}
