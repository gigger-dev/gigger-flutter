import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:ffmpeg_kit_flutter_new_min/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> cropGifWithFFmpeg(
  File file,
  CropImageData cropImageData,
  String fileName,
  Size size,
) async {
  try {
    var inputPath = file.path;
    var scale = cropImageData.scale;
    var angle = cropImageData.angle;
    var x = cropImageData.x;
    var y = cropImageData.y;

    var width = size.width;
    var height = size.height;

    // Prepare FFmpeg command
    String cropFilter = 'crop=$width:$height:$x:$y';
    String scaleFilter = 'scale=iw*$scale:ih*$scale';
    String rotateFilter = angle != 0 ? 'rotate=$angle*PI/180' : '';

    // Combine filters
    String filters = [
      cropFilter,
      scale != 1.0 ? scaleFilter : null,
      angle != 0 ? rotateFilter : null,
    ].where((filter) => filter != null).join(',');

    Directory tempDir = await getTemporaryDirectory();
    var dir = await tempDir.createTemp();

    var outputPath = p.join(dir.path, fileName);

    File outputFile = File(outputPath);
    if (await outputFile.exists()) {
      await outputFile.delete();
    }

    // FFmpeg command
    String command = '-i $inputPath -vf "$filters" -loop 0 $outputPath -y';

    Completer<bool> completer = Completer<bool>();

    // Execute the FFmpeg command
    await FFmpegKit.executeAsync(
      command,
      (session) async {
        final returnCode = await session.getReturnCode();
        if (returnCode?.isValueSuccess() == true) {
          // Command executed successfully
          completer.complete(true);
        } else {
          // Command failed
          completer.complete(false);
        }
      },
      (log) {
        debugPrint(log.getMessage());
      },
    );

    bool success = await completer.future;

    // Verify if the file was created
    if (success) {
      return outputFile;
    } else {
      debugPrint('Error: FFmpeg command execution failed.');
      return null;
    }
  } catch (e) {
    debugPrint('Error during GIF processing: $e');
    return null;
  }
}
