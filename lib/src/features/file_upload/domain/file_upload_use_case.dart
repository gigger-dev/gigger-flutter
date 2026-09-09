// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:io';

import '../../../../models/file_type.dart';
import '../../../../models/image_upload_response.dart';
import '../../../../models/simple_response.dart';

import 'file_upload_repo.dart';

Future<ImageUploadResponse> postApiV1FileUploadUseCase({
  required FileType fileType,
  required File file,
  required RmlsZVVwbG9hZFJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxRmlsZVVwbG9hZA(
    fileType: fileType,
    file: file,
  );
}

Future<ImageUploadResponse> postApiV1FileUploadOpenUseCase({
  required FileType fileType,
  required File file,
  required RmlsZVVwbG9hZFJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxRmlsZVVwbG9hZe9wZw4(
    fileType: fileType,
    file: file,
  );
}

Future<ImageUploadResponse> postApiV1FileUploadVideoUseCase({
  required File file,
  FileType fileType = FileType.media,
  required RmlsZVVwbG9hZFJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxRmlsZVVwbG9hZFZpZGVv(
    file: file,
    fileType: fileType,
  );
}

Future<SimpleResponse> postApiV1FileUploadDeleteUseCase({
  required String filePath,
  required RmlsZVVwbG9hZFJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxRmlsZVVwbG9hZERlbGv0ZQ(
    filePath: filePath,
  );
}
