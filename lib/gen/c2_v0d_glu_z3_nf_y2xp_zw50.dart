// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../models/basic_response.dart';
import '../../../../models/device_token_in.dart';
import '../../../../models/notification_out.dart';
import '../../../../models/server_config_out.dart';

part 'c2_v0d_glu_z3_nf_y2xp_zw50.g.dart';

const String l2FwaS92Ms9jb25maWcv = '/api/v1/config/';
const String l2FwaS92Ms9jb25maWcvZmNtX3Rva2VuLw = '/api/v1/config/fcm_token/';
const String l2FwaS92Ms9jb25maWcvbG9nb3V0Lw = '/api/v1/config/logout/';
const String l2FwaS92Ms9jb25maWcvbm90aWZpY2F0aW9ucy8 =
    '/api/v1/config/notifications/';
const String l2FwaS92Ms9jb25maWcvZ2V0X3N0cmVhbV9jaGf0X3Rva2Vu =
    '/api/v1/config/get_stream_chat_token';
const String l2FwaS92Ms9jb25maWcve25vdGlmaWNhdGlvbl91dWlkfS8 =
    '/api/v1/config/{notification_uuid}/';

const String zgv2aWNlX3V1aWQ = 'device_uuid';
const String dXNlcl91dWlk = 'user_uuid';
const String bm90aWZpY2F0aW9uX3V1aWQ = 'notification_uuid';

@RestApi()
abstract class U2V0dGluZ3NDbGllbnQ {
  factory U2V0dGluZ3NDbGllbnQ(Dio dio, {String? baseUrl}) =
      _U2V0dGluZ3NDbGllbnQ;

  @GET(l2FwaS92Ms9jb25maWcv)
  Future<ServerConfigOut> z2V0QXBpVjFDb25maWc();

  @POST(l2FwaS92Ms9jb25maWcvZmNtX3Rva2VuLw)
  Future<DeviceTokenIn> cG9zdEFwaVYxQ29uZmlnRmNtVg9rZw4({
    @Body() required DeviceTokenIn body,
  });

  @DELETE(l2FwaS92Ms9jb25maWcvbG9nb3V0Lw)
  Future<BasicResponse> zGVsZXRlQXBpVjFDb25maWdMb2dvdXQ({
    @Query(zgv2aWNlX3V1aWQ) required String deviceUuid,
  });

  @GET(l2FwaS92Ms9jb25maWcvbm90aWZpY2F0aW9ucy8)
  Future<List<NotificationOut>> z2V0QXBpVjFDb25maWdOb3RpZmljYXRpb25z();

  @GET(l2FwaS92Ms9jb25maWcvZ2V0X3N0cmVhbV9jaGf0X3Rva2Vu)
  Future<String> z2V0QXBpVjFDb25maWdHzxrTdHJlYw1DaGf0Vg9rZw4({
    @Query(dXNlcl91dWlk) required String userUuid,
  });

  @DELETE(l2FwaS92Ms9jb25maWcve25vdGlmaWNhdGlvbl91dWlkfS8)
  Future<BasicResponse> zGVsZXRlQXBpVjFDb25maWdOb3RpZmljYXRpb25VdWlk({
    @Path(bm90aWZpY2F0aW9uX3V1aWQ) required int notificationUuid,
  });
}
