import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:mobile_gigger_app/models/file_type.dart';
import 'package:path/path.dart' as p;
import 'package:uni_storage/uni_storage.dart';
import 'package:mime/mime.dart';

class AwsHelper {
  static var service = 's3';
  static var region = 'sgp1';
  static var bucket = 'gigger';
  static var accessKey = 'DO801GHTW7LFK9CKRG6R';
  static var secretKey = 'oqkjpClQZ8q+UjdFS7iCYvkcg+VUhhHvup+oL4DnAho';

  static Future<String?> upload({
    required String path,
    String? profileUuid,
    FileType fileType = FileType.media,
    void Function(int, int)? onSendProgress,
  }) async {
    var name =
        '${fileType.name.toUpperCase()}/${profileUuid == null ? '' : '$profileUuid/'}${p.basename(path)}';

    var r = await _uploadFile(
      name,
      File(path),
      lookupMimeType(path)!,
      Permissions.public,
      onSendProgress: onSendProgress,
    );

    return r == null ? null : name;
  }

  static Future<String?> _uploadFile(
    String key,
    File file,
    String contentType,
    Permissions permissions, {
    Map<String, String>? meta,
    void Function(int, int)? onSendProgress,
  }) async {
    final dio = Dio();

    int contentLength = await file.length();
    Digest contentSha256 = await sha256.bind(file.openRead()).first;

    var endpointUrl = 'https://$bucket.$region.digitaloceanspaces.com';

    String uriStr = '$endpointUrl/$key';
    Uri uri = Uri.parse(uriStr);

    // Read file as bytes
    final fileBytes = await file.readAsBytes();

    final headers = <String, String>{
      'Content-Length': contentLength.toString(),
      'Content-Type': contentType,
    };

    if (meta != null) {
      for (final entry in meta.entries) {
        headers['x-amz-meta-${entry.key}'] = entry.value;
      }
    }

    if (permissions == Permissions.public) {
      headers['x-amz-acl'] = 'public-read';
    }

    // Sign the headers using your method
    _signRequest(uri, headers, contentSha256: contentSha256);

    try {
      final response = await dio.putUri(
        uri,
        data: Stream.fromIterable([fileBytes]),
        options: Options(headers: headers),
        onSendProgress: onSendProgress,
      );

      if (response.statusCode != 200) {
        throw ClientException(
          response.statusCode ?? 0,
          response.statusMessage,
          response.headers.map.map((k, v) => MapEntry(k, v.join(','))),
          response.data.toString(),
        );
      }

      return response.headers.value('etag');
    } on DioException catch (e) {
      throw ClientException(
        e.response?.statusCode ?? 0,
        e.message,
        e.response?.headers.map.map((k, v) => MapEntry(k, v.join(','))) ?? {},
        e.response?.data?.toString() ?? '',
      );
    }
  }

  static String _uriEncode(String str) {
    return Uri.encodeQueryComponent(str).replaceAll('+', '%20');
  }

  static String _trimAll(String str) {
    String res = str.trim();
    int len;
    do {
      len = res.length;
      res = res.replaceAll('  ', ' ');
    } while (res.length != len);
    return res;
  }

  static String? _signRequest(
    Uri uri,
    Map<String, String> headers, {
    Digest? contentSha256,
    bool preSignedUrl = false,
    int expires = 86400,
  }) {
    String httpMethod = 'PUT';
    String canonicalURI = uri.path;
    String host = uri.host;

    DateTime date = DateTime.now().toUtc();
    String dateIso8601 = date.toIso8601String();
    dateIso8601 =
        '${dateIso8601.substring(0, dateIso8601.indexOf('.')).replaceAll(':', '').replaceAll('-', '')}Z';
    String dateYYYYMMDD =
        '${date.year.toString().padLeft(4, '0')}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';

    String hashedPayloadStr =
        contentSha256 == null ? 'UNSIGNED-PAYLOAD' : '$contentSha256';

    String credential =
        '$accessKey/$dateYYYYMMDD/$region/$service/aws4_request';

    // Canonical headers
    final canonicalHeadersMap = <String, String>{};
    if (!preSignedUrl) {
      headers['x-amz-date'] = dateIso8601;
      if (contentSha256 != null) {
        headers['x-amz-content-sha256'] = hashedPayloadStr;
      }
      for (final key in headers.keys) {
        canonicalHeadersMap[key.toLowerCase()] = headers[key]!;
      }
    }
    canonicalHeadersMap['host'] = host;

    final sortedHeaderKeys = canonicalHeadersMap.keys.toList()..sort();
    final canonicalHeaders = sortedHeaderKeys
        .map((k) => '$k:${_trimAll(canonicalHeadersMap[k]!)}\n')
        .join();
    final signedHeaders = sortedHeaderKeys.join(';');

    // Canonical query string
    final queryParameters = <String, String>{}..addAll(uri.queryParameters);
    if (preSignedUrl) {
      queryParameters['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
      queryParameters['X-Amz-Credential'] = credential;
      queryParameters['X-Amz-Date'] = dateIso8601;
      queryParameters['X-Amz-Expires'] = expires.toString();
      if (contentSha256 != null) {
        queryParameters['X-Amz-Content-Sha256'] = hashedPayloadStr;
      }
      queryParameters['X-Amz-SignedHeaders'] = signedHeaders;
    }
    final sortedQueryKeys = queryParameters.keys.toList()..sort();
    final canonicalQueryString = sortedQueryKeys
        .map((k) => '${_uriEncode(k)}=${_uriEncode(queryParameters[k]!)}')
        .join('&');

    if (preSignedUrl) {
      hashedPayloadStr = 'UNSIGNED-PAYLOAD';
    }

    // Canonical request
    final canonicalRequest =
        '$httpMethod\n$canonicalURI\n$canonicalQueryString\n$canonicalHeaders\n$signedHeaders\n$hashedPayloadStr';
    final canonicalRequestHash = sha256.convert(utf8.encode(canonicalRequest));

    final stringToSign =
        'AWS4-HMAC-SHA256\n$dateIso8601\n$dateYYYYMMDD/$region/$service/aws4_request\n$canonicalRequestHash';

    final dateKey = Hmac(sha256, utf8.encode('AWS4$secretKey'))
        .convert(utf8.encode(dateYYYYMMDD));
    final dateRegionKey =
        Hmac(sha256, dateKey.bytes).convert(utf8.encode(region));
    final dateRegionServiceKey =
        Hmac(sha256, dateRegionKey.bytes).convert(utf8.encode(service));
    final signingKey = Hmac(sha256, dateRegionServiceKey.bytes)
        .convert(utf8.encode('aws4_request'));

    final signature =
        Hmac(sha256, signingKey.bytes).convert(utf8.encode(stringToSign));

    headers['Authorization'] =
        'AWS4-HMAC-SHA256 Credential=$credential, SignedHeaders=$signedHeaders, Signature=$signature';

    if (preSignedUrl) {
      queryParameters['X-Amz-Signature'] = '$signature';
      return uri.replace(queryParameters: queryParameters).toString();
    } else {
      return null;
    }
  }
}
