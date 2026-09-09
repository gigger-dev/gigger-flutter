import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_gigger_app/core/extension/content_type_extension.dart';
import 'package:mobile_gigger_app/core/helpers/aws_helper.dart';
import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/models/call_to_action.dart';
import 'package:mobile_gigger_app/models/gig_list_media.dart';
import 'package:mobile_gigger_app/models/hash_tag.dart';
import 'package:mobile_gigger_app/models/sup_created_from_enum.dart';

Future<void> postIsolateAPI(Map<String, dynamic> data) async {
  var sendPort = data['sendPort'] as SendPort;
  var rootIsolateToken = data['rootIsolateToken'] as RootIsolateToken;
  var uuid = data['uuid'] as String?;
  var title = data['title'] as String;
  var caption = data['caption'] as String;
  var videoUrl = data['videoUrl'] as String?;
  var type = ContentType.values[data['type'] as int];
  var musicTitle = data['musicTitle'] as String;
  var wageRequested = data['wageRequested'] as int;
  var tags = List<HashTag>.from(
      (data['tags'] as List).map((e) => HashTag.fromJson(e)));
  var taggedProfiles = data['taggedProfiles'] as List<String>? ?? [];
  var profileUuid = data['profileUuid'] as String;
  var pickVideoFile = data['pickVideoFile'] as String?;
  var thumbnailImageFile = data['thumbnailImageFile'] as String?;
  var thumbnailImageUrl = data['thumbnailImageUrl'] as String?;
  var gigListMedia = Map.fromEntries(
    (data['gigListMedia'] as Map<String, dynamic>)
        .entries
        .map((e) => MapEntry(e.key, GigListMedia.fromJson(e.value))),
  );
  var location = data['location'] as String?;
  var isPerformer = data['isPerformer'] as bool;
  var isLookingFor = data['isLookingFor'] as bool;
  var addCallToAction = data['addCallToAction'] as bool;
  var isMembershipOnly = data['isMembershipOnly'] as bool;
  var isOnlyForFollowers = data['isOnlyForFollowers'] as bool;
  var isDraft = data['isDraft'] as bool;
  var isPrivate = data['isPrivate'] as bool;
  var lat = data['lat'] as num?;
  var long = data['long'] as num?;
  var callToAction = data['callToAction'] == null
      ? CallToAction(name: 'None', value: '')
      : CallToAction.fromJson(data['callToAction'] as Map<String, dynamic>);
  var createFrom = SupCreatedFromEnum.values[data['createdFrom'] as int];

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
    List<GigListMedia> _medias = [];

    try {
      if (pickVideoFile != null || thumbnailImageFile != null) {
        var files = await _uploadFile(
          ref: ref,
          profileUuid: profileUuid,
          responsePort: responsePort,
          gigListMedia: gigListMedia,
          pickVideoFile: pickVideoFile,
          thumbnailImageFile: thumbnailImageFile,
        );
        _videoUrl = files.$1 ?? '';
        _thumbnailUrl = files.$2 ?? '';
        _medias = files.$3;
      } else if (gigListMedia.isNotEmpty) {
        var files = await _uploadFile(
          ref: ref,
          profileUuid: profileUuid,
          responsePort: responsePort,
          gigListMedia: gigListMedia,
        );
        _videoUrl = videoUrl ?? '';
        _thumbnailUrl = thumbnailImageUrl ?? '';
        _medias = files.$3;
      } else {
        _videoUrl = videoUrl ?? '';
        _thumbnailUrl = thumbnailImageUrl ?? '';
      }

      await type.getUtil().api(
            lat: lat,
            ref: ref,
            long: long,
            uuid: uuid,
            title: title,
            hashtags: tags,
            medias: _medias,
            caption: caption,
            isDraft: isDraft,
            location: location,
            videoUrl: _videoUrl,
            isPrivate: isPrivate,
            createFrom: createFrom,
            musicTitle: musicTitle,
            profileUuid: profileUuid,
            isPerformer: isPerformer,
            isLookingFor: isLookingFor,
            callToAction: callToAction,
            thumbnailUrl: _thumbnailUrl,
            wageRequested: wageRequested,
            taggedProfiles: taggedProfiles,
            addCallToAction: addCallToAction,
            isMembershipOnly: isMembershipOnly,
            isOnlyForFollowers: isOnlyForFollowers,
          );

      responsePort.send(1.0);
    } catch (_) {
      responsePort.send(-1.0);
    }
  }
}

Future<(String?, String?, List<GigListMedia>)> _uploadFile({
  String? pickVideoFile,
  String? thumbnailImageFile,
  required String profileUuid,
  required Map<String, GigListMedia> gigListMedia,
  required SendPort responsePort,
  required ProviderContainer ref,
}) async {
  var totalPercentage = 0.0;

  var totalCount = [thumbnailImageFile, pickVideoFile, ...gigListMedia.values]
      .whereNotNull()
      .length;

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
        // file: File(pickVideoFile),
        // dio: ref.read(dioProvider),
        // onSendProgress: (count, total) {
        //   var percentage = count / total;
        //   totalPercentage += percentage / totalCount;
        //   if (totalPercentage > .8) return;
        //   responsePort.send(totalPercentage);
        // },
      );
    } catch (e) {
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
      //   file: File(thumbnailImageFile),
      //   dio: ref.read(dioProvider),
      //   fileType: FileType.media,
      //   onSendProgress: (count, total) {
      //     var percentage = count / total;
      //     totalPercentage += percentage / totalCount;
      //     if (totalPercentage > .8) return;
      //     responsePort.send(totalPercentage);
      //   },
      // );
    } catch (e) {
      responsePort.send(-1.0);
    }
  }

  List<GigListMedia> medias = [];

  for (var i = 0; i < gigListMedia.values.length; i++) {
    var m = gigListMedia.values.elementAt(i);

    if (m.mediaUrl.startsWith('MEDIA')) {
      medias.add(m);
      continue;
    }

    String? r;

    if (m.isVideo) {
      r = await AwsHelper.upload(
        path: m.mediaUrl,
        profileUuid: profileUuid,
        onSendProgress: (count, total) {
          var percentage = count / total;
          totalPercentage += percentage / totalCount;
          if (totalPercentage > .8) return;
          responsePort.send(totalPercentage);
        },
      );
      // r = await postApiV1FileUploadVideo(
      //   file: File(m.mediaUrl),
      //   dio: ref.read(dioProvider),
      //   onSendProgress: (count, total) {
      //     var percentage = count / total;
      //     totalPercentage += percentage / totalCount;
      //     if (totalPercentage > .8) return;
      //     responsePort.send(totalPercentage);
      //   },
      // );
    } else {
      r = await AwsHelper.upload(
        path: m.mediaUrl,
        profileUuid: profileUuid,
        onSendProgress: (count, total) {
          var percentage = count / total;
          totalPercentage += percentage / totalCount;
          if (totalPercentage > .8) return;
          responsePort.send(totalPercentage);
        },
      );
      // r = await postApiV1FileUpload(
      //   file: File(m.mediaUrl),
      //   fileType: FileType.media,
      //   dio: ref.read(dioProvider),
      //   onSendProgress: (count, total) {
      //     var percentage = count / total;
      //     totalPercentage += percentage / totalCount;
      //     if (totalPercentage > .8) return;
      //     responsePort.send(totalPercentage);
      //   },
      // );
    }

    medias.add(GigListMedia(mediaUrl: r ?? '', isVideo: m.isVideo));
  }

  return (videoR, thumbnailR, medias);
}
