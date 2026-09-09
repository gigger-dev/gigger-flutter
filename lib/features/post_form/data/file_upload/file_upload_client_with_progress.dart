import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobile_gigger_app/models/file_type.dart';
import 'package:mobile_gigger_app/models/image_upload_response.dart';
import 'package:retrofit/retrofit.dart';

Future<ImageUploadResponse> postApiV1FileUpload({
  required FileType fileType,
  required File file,
  required Dio dio,
  String? baseUrl,
  ParseErrorLogger? errorLogger,
  ProgressCallback? onSendProgress,
}) async {
  final _extra = <String, dynamic>{};
  final queryParameters = <String, dynamic>{r'file_type': fileType.name};
  final _headers = <String, dynamic>{};
  final _data = FormData();
  _data.files.add(MapEntry(
    'file',
    MultipartFile.fromFileSync(
      file.path,
      filename: file.path.split(Platform.pathSeparator).last,
    ),
  ));
  final _options = _setStreamType<ImageUploadResponse>(Options(
    method: 'POST',
    headers: _headers,
    extra: _extra,
    contentType: 'multipart/form-data',
  )
      .compose(
        dio.options,
        '/api/v1/file_upload/',
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        data: _data,
      )
      .copyWith(
          baseUrl: _combineBaseUrls(
        dio.options.baseUrl,
        baseUrl,
      )));

  final _result = await dio.fetch<Map<String, dynamic>>(_options);
  late ImageUploadResponse _value;
  try {
    _value = ImageUploadResponse.fromJson(_result.data!);
  } on Object catch (e, s) {
    errorLogger?.logError(e, s, _options);
    rethrow;
  }
  return _value;
}

Future<ImageUploadResponse> postApiV1FileUploadVideo({
  required File file,
  FileType fileType = FileType.media,
  required Dio dio,
  String? baseUrl,
  ParseErrorLogger? errorLogger,
  ProgressCallback? onSendProgress,
}) async {
  final _extra = <String, dynamic>{};
  final queryParameters = <String, dynamic>{r'file_type': fileType.name};
  final _headers = <String, dynamic>{};
  final _data = FormData();
  _data.files.add(MapEntry(
    'file',
    MultipartFile.fromFileSync(
      file.path,
      filename: file.path.split(Platform.pathSeparator).last,
    ),
  ));
  final _options = _setStreamType<ImageUploadResponse>(Options(
    method: 'POST',
    headers: _headers,
    extra: _extra,
    contentType: 'multipart/form-data',
  )
      .compose(
        dio.options,
        '/api/v1/file_upload/video/',
        queryParameters: queryParameters,
        data: _data,
        onSendProgress: onSendProgress,
      )
      .copyWith(
          baseUrl: _combineBaseUrls(
        dio.options.baseUrl,
        baseUrl,
      )));
  final _result = await dio.fetch<Map<String, dynamic>>(_options);
  late ImageUploadResponse _value;
  try {
    _value = ImageUploadResponse.fromJson(_result.data!);
  } on Object catch (e, s) {
    errorLogger?.logError(e, s, _options);
    rethrow;
  }
  return _value;
}

RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
  if (T != dynamic &&
      !(requestOptions.responseType == ResponseType.bytes ||
          requestOptions.responseType == ResponseType.stream)) {
    if (T == String) {
      requestOptions.responseType = ResponseType.plain;
    } else {
      requestOptions.responseType = ResponseType.json;
    }
  }
  return requestOptions;
}

String _combineBaseUrls(
  String dioBaseUrl,
  String? baseUrl,
) {
  if (baseUrl == null || baseUrl.trim().isEmpty) {
    return dioBaseUrl;
  }

  final url = Uri.parse(baseUrl);

  if (url.isAbsolute) {
    return url.toString();
  }

  return Uri.parse(dioBaseUrl).resolveUri(url).toString();
}
