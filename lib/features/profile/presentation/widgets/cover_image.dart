import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({
    super.key,
    required this.coverImageFile,
    required this.coverMedia,
    required this.cropController,
    required this.coverFile,
  });

  final File? coverFile;
  final String coverMedia;
  final MemoryImage? coverImageFile;
  final CustomImageCropController cropController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      height: .7.sh,
      child: Container(
        foregroundDecoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0, .2],
          ),
        ),
        decoration: coverFile != null
            ? null
            : BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(coverMedia),
                ),
              ),
        child: coverFile != null
            ? CustomImageCrop(
                cropPercentage: 1,
                forceInsideCropArea: true,
                image: FileImage(coverFile!),
                shape: CustomCropShape.Ratio,
                backgroundColor: Colors.black,
                cropController: cropController,
                overlayColor: Colors.transparent,
                ratio: Ratio(width: 9, height: 16),
                imageFit: CustomImageFit.fitVisibleSpace,
                pathPaint: Paint()..style = PaintingStyle.fill,
                imagePaintDuringCrop: Paint()..style = PaintingStyle.fill,
              )
            : null,
      ),
    );
  }
}
