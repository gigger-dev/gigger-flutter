import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_gigger_app/core/helpers/aws_helper.dart';
import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/features/event_form/providers/event_form_controller.dart';
import 'package:mobile_gigger_app/models/event_in.dart';
import 'package:mobile_gigger_app/models/line_up_and_performer_in.dart';

Future<void> eventIsolateAPI(Map<String, dynamic> data) async {
  var sendPort = data['sendPort'] as SendPort;
  var rootIsolateToken = data['rootIsolateToken'] as RootIsolateToken;

  var uuid = data['uuid'] as String?;
  var profileUuid = data['profile_uuid'] as String;
  var pickVideoFile = data['pickVideoFile'] as String?;
  var thumbnailFile = data['thumbnailFile'] as String?;
  var model = EventIn.fromJson(data);

  var lineUpNPerformersToAdd =
      data['line_up_n_performers_to_add'] as List<LineUpAndPerformerIn>;
  var lineUpNPerformersToRemove =
      data['line_up_n_performers_to_remove'] as List<LineUpAndPerformerIn>;

  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  final port = ReceivePort();
  sendPort.send(port.sendPort);

  var ref = ProviderContainer(
    overrides: [
      secureStorageProvider.overrideWithValue(FlutterSecureStorage(
        aOptions: AndroidOptions(
          keyCipherAlgorithm:
              KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
          storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
        ),
      )),
    ],
  );

  await for (final message in port) {
    final responsePort = message['responsePort'] as SendPort;

    String? _videoUrl;
    String? _thumbnailUrl;

    try {
      if (pickVideoFile != null || thumbnailFile != null) {
        var files = await _uploadFile(
          ref: ref,
          profileUuid: profileUuid,
          responsePort: responsePort,
          pickVideoFile: pickVideoFile,
          thumbnailImageFile: thumbnailFile,
        );

        _videoUrl = files.$1;
        _thumbnailUrl = files.$2;
      }

      if (uuid != null) {
        await ref.read(eventFormControllerProvider.notifier).update(
              uuid: uuid,
              data: model,
              videoUrl: _videoUrl,
              thumbnailUrl: _thumbnailUrl,
              lineUpNPerformersToAdd: lineUpNPerformersToAdd,
              lineUpNPerformersToRemove: lineUpNPerformersToRemove,
            );
      } else {
        var data = model;
        if (_videoUrl != null) {
          data = data.copyWith(videoOrImageUrl: _videoUrl);
        }
        if (_thumbnailUrl != null) {
          data = data.copyWith(thumbnailUrl: _thumbnailUrl);
        }
        await ref.read(eventFormControllerProvider.notifier).create(data);
      }
      responsePort.send(1.0);
    } catch (e) {
      responsePort.send(-1.0);
    }
  }
}

Future<(String?, String?)> _uploadFile({
  String? pickVideoFile,
  String? thumbnailImageFile,
  required String profileUuid,
  required SendPort responsePort,
  required ProviderContainer ref,
}) async {
  var totalPercentage = 0.0;

  var totalCount = [thumbnailImageFile, pickVideoFile].whereNotNull().length;

  String? videoR;

  if (pickVideoFile != null) {
    try {
      videoR = await AwsHelper.upload(
        path: pickVideoFile,
        profileUuid: profileUuid,
        onSendProgress: (count, total) {
          var percentage = count / total;
          totalPercentage += percentage / totalCount;
          if (totalPercentage > .8) return;
          responsePort.send(totalPercentage);
        },
      );

      // videoR = await postApiV1FileUploadVideo(
      //   file: File(pickVideoFile),
      //   fileType: FileType.media,
      //   dio: ref.read(dioProvider),
      //   onSendProgress: (count, total) {
      //     var percentage = count / total;
      //     totalPercentage += percentage / totalCount;
      //     if (totalPercentage > .8) return;
      //     responsePort.send(totalPercentage);
      //   },
      // );
    } catch (_) {
      responsePort.send(-1.0);
    }
  }

  String? thumbnailR;

  if (thumbnailImageFile != null) {
    try {
      thumbnailR = await AwsHelper.upload(
        path: thumbnailImageFile,
        profileUuid: profileUuid,
        onSendProgress: (count, total) {
          var percentage = count / total;
          totalPercentage += percentage / totalCount;
          if (totalPercentage > .8) return;
          responsePort.send(totalPercentage);
        },
      );

      // thumbnailR = await postApiV1FileUpload(
      //   fileType: FileType.media,
      //   dio: ref.read(dioProvider),
      //   file: File(thumbnailImageFile),
      //   onSendProgress: (count, total) {
      //     var percentage = count / total;
      //     totalPercentage += percentage / totalCount;
      //     if (totalPercentage > .8) return;
      //     responsePort.send(totalPercentage);
      //   },
      // );
    } catch (_) {
      responsePort.send(-1.0);
    }
  }

  return (videoR, thumbnailR);
}
