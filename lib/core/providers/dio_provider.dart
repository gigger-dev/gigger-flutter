import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/const.dart';
import 'package:mobile_gigger_app/core/helpers/network_helper.dart';
import 'package:mobile_gigger_app/core/providers/secure_storage_provider.dart';
import 'package:mobile_gigger_app/core/providers/token_controller.dart';
import 'package:mobile_gigger_app/features/auth/presentation/providers/auth_controller.dart';
import 'package:mobile_gigger_app/features/splash/providers/splash_controller.dart';
import 'package:mobile_gigger_app/models/validation_error.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  var dio = Dio();
  dio.options.baseUrl = baseUrl;
  dio.options.validateStatus = (int? status) => true;

  dio.options.responseType = ResponseType.json;
  dio.options.connectTimeout = const Duration(minutes: 3);
  dio.options.sendTimeout = const Duration(minutes: 3);
  dio.options.receiveTimeout = const Duration(minutes: 3);

  dio.interceptors.add(LogInterceptor(
    requestBody: kDebugMode,
    responseBody: kDebugMode,
    requestHeader: kDebugMode,
    responseHeader: kDebugMode,
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      var isNetwork = await NetworkHelper.check();

      if (!isNetwork) {
        return handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
          ),
        );
      }

      var storage = ref.read(secureStorageProvider);

      var session = await storage.read(key: 'session');

      var token = await ref.read(tokenControllerProvider.notifier).getToken();

      if (token == null && session == null) return handler.next(options);

      if (!options.headers.containsKey('authorization')) {
        options.headers['authorization'] = 'Bearer ${token ?? session}';
      }

      return handler.next(options);
    },
    onResponse: (r, handler) async {
      if (r.statusCode == 401) {
        var token =
            await ref.read(authControllerProvider.notifier).refreshToken();
        if (token == null) {
          return ref.read(authControllerProvider.notifier).deleteAndReset();
        }

        var option = r.requestOptions;
        option.headers['authorization'] = 'Bearer $token';
        return handler.resolve(await dio.fetch(option));
      }

      if (r.statusCode == 403) {
        var detail = r.data['detail'] as String;

        return handler.reject(HttpValidationException(
          requestOptions: r.requestOptions,
          message: detail,
        ));
      }

      if (r.statusCode == 422) {
        var detail = r.data['detail'] as List;
        return handler.reject(HttpValidationException(
          requestOptions: r.requestOptions,
          error: detail.map((e) => ValidationError.fromJson(e)).toList(),
        ));
      }

      if (r.statusCode == 400) {
        var detail = (r.data['detail'] as String).split('.').first;
        return handler.reject(HttpValidationException(
          requestOptions: r.requestOptions,
          message: detail,
        ));
      }

      return handler.next(r);
    },
    onError: (e, handler) async {
      if (e.type == DioExceptionType.connectionError) {
        Toast.show('No Internet Connection');
        return handler.reject(e);
      }

      if (e.response?.statusCode == 401) {
        var token =
            await ref.read(authControllerProvider.notifier).refreshToken();
        if (token == null) {
          return ref.read(authControllerProvider.notifier).deleteAndReset();
        }
      }

      if (e.response?.statusCode == 422) {
        if (kReleaseMode) {
          FirebaseCrashlytics.instance
              .recordError(e.error, e.stackTrace, fatal: true);
        }

        var detail = e.response!.data['detail'] as List;
        return handler.next(HttpValidationException(
          requestOptions: e.requestOptions,
          error: detail.map((e) => ValidationError.fromJson(e)).toList(),
        ));
      }

      var errorMsg =
          '${e.response?.data['detail'] ?? e.type.toPrettyDescription()}';

      Toast.error(errorMsg);

      ref.read(splashControllerProvider.notifier).update(errorMsg);

      return handler.next(e);
    },
  ));

  return dio;
}

class HttpValidationException extends DioException {
  HttpValidationException({
    required super.requestOptions,
    super.error,
    super.message,
  });
}

extension _DioExceptionTypeExtension on DioExceptionType {
  String toPrettyDescription() {
    switch (this) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout! Please try again';
      case DioExceptionType.sendTimeout:
        return 'Send Timeout! Please try again';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout! Please try again';
      case DioExceptionType.badCertificate:
        return 'Bad certificate! Please try again';
      case DioExceptionType.badResponse:
        return 'Bad response! Please try again';
      case DioExceptionType.cancel:
        return 'Request cancelled! Please try again';
      case DioExceptionType.connectionError:
        return 'Connection error! Please try again';
      case DioExceptionType.unknown:
        return 'Unknown error! Please try again';
      case DioExceptionType.transformTimeout:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
