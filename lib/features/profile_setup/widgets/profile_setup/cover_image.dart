import 'dart:io';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({
    super.key,
    required this.coverImageFinalFile,
    required this.coverImageFile,
    required this.cropController,
    required this.onTap,
    required this.onRemove,
    required this.isCover,
  });

  final File? coverImageFile;
  final MemoryImage? coverImageFinalFile;
  final CustomImageCropController cropController;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final bool isCover;

  @override
  Widget build(BuildContext context) {
    Widget child = InkWell(
      onTap: onTap,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 90),
          Icon(Icons.add, size: 32, color: Colors.white),
          SizedBox(height: 6),
          TextViewWidget(text: 'Add your cover*', color: colorRed),
          TextViewWidget(text: '(image or 5 sec gif)', color: colorRed),
        ],
      ),
    );

    if (coverImageFile != null) {
      child = CustomImageCrop(
        cropPercentage: 1,
        clipShapeOnCrop: false,
        forceInsideCropArea: true,
        shape: CustomCropShape.Ratio,
        backgroundColor: Colors.black,
        cropController: cropController,
        overlayColor: Colors.transparent,
        image: FileImage(coverImageFile!),
        ratio: Ratio(width: 9, height: 16),
        imageFit: CustomImageFit.fitVisibleSpace,
        pathPaint: Paint()..style = PaintingStyle.fill,
        imagePaintDuringCrop: Paint()..style = PaintingStyle.fill,
      );
    }

    if (coverImageFinalFile != null) {
      child = InkWell(
        onTap: onRemove,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: coverImageFinalFile!,
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child: !isCover
              ? null
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  child: const TextViewWidget(text: 'Remove', color: colorRed),
                ),
        ),
      );
    }

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: .7.sh,
        foregroundDecoration:
            coverImageFinalFile == null && coverImageFile == null
                ? null
                : const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.black54,
                        Colors.transparent,
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0, .1, .15, .2],
                    ),
                  ),
        child: child,
      ),
    );
  }
}
