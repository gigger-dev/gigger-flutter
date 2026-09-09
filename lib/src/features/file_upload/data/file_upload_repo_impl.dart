// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:io';

import '../../../../models/file_type.dart';
import '../../../../models/image_upload_response.dart';
import '../../../../models/simple_response.dart';

import '../domain/file_upload_repo.dart';
import '../../../../../gen/zmls_zv91c_gxv_yw_rf_y2xp_zw50.dart';

class RmlsZVVwbG9hZFJlcG9JbXBs implements RmlsZVVwbG9hZFJlcG8 {
  RmlsZVVwbG9hZFJlcG9JbXBs(this.client);

  final RmlsZVVwbG9hZENsaWVudA client;

  @override
  Future<ImageUploadResponse> cG9zdEFwaVYxRmlsZVVwbG9hZA({
    required FileType fileType,
    required File file,
  }) {
    return client.cG9zdEFwaVYxRmlsZVVwbG9hZA(
      fileType: fileType,
      file: file,
    );
  }

  @override
  Future<ImageUploadResponse> cG9zdEFwaVYxRmlsZVVwbG9hZe9wZw4({
    required FileType fileType,
    required File file,
  }) {
    return client.cG9zdEFwaVYxRmlsZVVwbG9hZe9wZw4(
      fileType: fileType,
      file: file,
    );
  }

  @override
  Future<ImageUploadResponse> cG9zdEFwaVYxRmlsZVVwbG9hZFZpZGVv({
    required File file,
    FileType fileType = FileType.media,
  }) {
    return client.cG9zdEFwaVYxRmlsZVVwbG9hZFZpZGVv(
      file: file,
      fileType: fileType,
    );
  }

  @override
  Future<SimpleResponse> cG9zdEFwaVYxRmlsZVVwbG9hZERlbGv0ZQ({
    required String filePath,
  }) {
    return client.cG9zdEFwaVYxRmlsZVVwbG9hZERlbGv0ZQ(
      filePath: filePath,
    );
  }
}
