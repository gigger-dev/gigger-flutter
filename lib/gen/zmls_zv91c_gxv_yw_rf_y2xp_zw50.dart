// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../models/file_type.dart';
import '../../../../models/image_upload_response.dart';
import '../../../../models/simple_response.dart';

part 'zmls_zv91c_gxv_yw_rf_y2xp_zw50.g.dart';

const String l2FwaS92Ms9maWxlX3VwbG9hZc8 = '/api/v1/file_upload/';
const String l2FwaS92Ms9maWxlX3VwbG9hZc9vcGVuLw = '/api/v1/file_upload/open/';
const String l2FwaS92Ms9maWxlX3VwbG9hZc92aWRlby8 = '/api/v1/file_upload/video/';
const String l2FwaS92Ms9maWxlX3VwbG9hZc9kZWxldGUv =
    '/api/v1/file_upload/delete/';

const String zmlsZv90eXBl = 'file_type';
const String zmlsZQ = 'file';
const String zmlsZv9wYXRo = 'file_path';

@RestApi()
abstract class RmlsZVVwbG9hZENsaWVudA {
  factory RmlsZVVwbG9hZENsaWVudA(Dio dio, {String? baseUrl}) =
      _RmlsZVVwbG9hZENsaWVudA;

  @MultiPart()
  @POST(l2FwaS92Ms9maWxlX3VwbG9hZc8)
  Future<ImageUploadResponse> cG9zdEFwaVYxRmlsZVVwbG9hZA({
    @Query(zmlsZv90eXBl) required FileType fileType,
    @Part(name: zmlsZQ) required File file,
  });

  @MultiPart()
  @POST(l2FwaS92Ms9maWxlX3VwbG9hZc9vcGVuLw)
  Future<ImageUploadResponse> cG9zdEFwaVYxRmlsZVVwbG9hZe9wZw4({
    @Query(zmlsZv90eXBl) required FileType fileType,
    @Part(name: zmlsZQ) required File file,
  });

  @MultiPart()
  @POST(l2FwaS92Ms9maWxlX3VwbG9hZc92aWRlby8)
  Future<ImageUploadResponse> cG9zdEFwaVYxRmlsZVVwbG9hZFZpZGVv({
    @Part(name: zmlsZQ) required File file,
    @Query(zmlsZv90eXBl) FileType fileType = FileType.media,
  });

  @POST(l2FwaS92Ms9maWxlX3VwbG9hZc9kZWxldGUv)
  Future<SimpleResponse> cG9zdEFwaVYxRmlsZVVwbG9hZERlbGv0ZQ({
    @Query(zmlsZv9wYXRo) required String filePath,
  });
}
