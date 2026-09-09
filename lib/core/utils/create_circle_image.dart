import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

Future<Uint8List> createCircularImage(
  Uint8List imageData,
  double size,
) async {
  // Decode the image from byte data
  ui.Codec codec = await ui.instantiateImageCodec(imageData);
  ui.FrameInfo frame = await codec.getNextFrame();
  ui.Image originalImage = frame.image;

  // Create a recorder and canvas
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(recorder);
  final Paint paint = Paint();

  // Define a circular clip
  final Rect rect = Rect.fromLTWH(0, 0, size, size);
  final Radius radius = Radius.circular(size / 2);
  final Path path = Path()
    ..addRRect(
      RRect.fromRectAndCorners(
        rect,
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
    );

  // Draw the circular clip
  canvas.clipPath(path);
  canvas.drawImageRect(
    originalImage,
    Rect.fromLTWH(
        0, 0, originalImage.width.toDouble(), originalImage.height.toDouble()),
    rect,
    paint,
  );

  // End the recording
  final ui.Picture picture = recorder.endRecording();
  final ui.Image circularImage =
      await picture.toImage(size.toInt(), size.toInt());

  // Convert the circular image to byte data
  var byteData = await circularImage.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
