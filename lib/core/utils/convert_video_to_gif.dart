import 'dart:async';
import 'dart:io';
import 'package:ffmpeg_kit_flutter_new_min/return_code.dart';
import 'package:path/path.dart' as p;

import 'package:ffmpeg_kit_flutter_new_min/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> convertVideoToGif({
  required String videoPath,
  required String fileName,
}) async {
  try {
    Directory tempDir = await getTemporaryDirectory();
    var dir = await tempDir.createTemp();

    var outputPath = p.join(dir.path, fileName);
    File outputFile = File(outputPath);
    if (await outputFile.exists()) {
      await outputFile.delete();
    }

    // final result = await FFmpegKit.execute('-i $videoPath');
    // final output = await result.getOutput();

    // final fpsRegex = RegExp(r'(\d+(\.\d+)?)\s*fps');
    // final fps = fpsRegex.firstMatch(output!)!.group(1);

    var fps = 15;

    File repairedVideofile = File(p.join(dir.path, 'repaired_video.mp4'));
    if (await repairedVideofile.exists()) {
      await repairedVideofile.delete();
    }

    await FFmpegKit.execute(
      '-i $videoPath -c:v copy -c:a copy ${repairedVideofile.path}',
    );

    var session = await FFmpegKit.execute(
      '-i ${repairedVideofile.path} -vf "fps=$fps" -t 6 -c:v gif $outputPath',
    );

    final returnCode = await session.getReturnCode();
    if (ReturnCode.isSuccess(returnCode)) {
      File outputGif = File(outputPath);
      if (await outputGif.exists()) {
        return outputGif;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
