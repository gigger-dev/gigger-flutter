// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../models/account_out.dart';
import '../../../../models/forgot_password.dart';
import '../../../../models/register_success.dart';
import '../../../../models/reset_password.dart';
import '../../../../models/reset_request_success.dart';
import '../../../../models/sign_in.dart';
import '../../../../models/sign_in_success.dart';
import '../../../../models/sign_up.dart';
import '../../../../models/token_out.dart';
import '../../../../models/verify_otp.dart';

part 'yxv0a_f9jb_gllbn_q.g.dart';

const String l2FwaS92Ms9hY2NvdW50cy9yZWdpc3Rlcg = '/api/v1/accounts/register';
const String l2FwaS92Ms9hY2NvdW50cy9zaWduLWlu = '/api/v1/accounts/sign-in';
const String l2FwaS92Ms9hY2NvdW50cy9yZXNldC1wYXNzd29yZc1yZxf1Zxn0 =
    '/api/v1/accounts/reset-password-request';
const String l2FwaS92Ms9hY2NvdW50cy92ZXJpZnktb3Rw =
    '/api/v1/accounts/verify-otp';
const String l2FwaS92Ms9hY2NvdW50cy9tZQ = '/api/v1/accounts/me';
const String l2FwaS92Ms9hY2NvdW50cy9kZXYvZGVsZXRlX2FjY291bnQ =
    '/api/v1/accounts/dev/delete_account';
const String l2FwaS92Ms9hY2NvdW50cy9yZXNldC1wYXNzd29yZA =
    '/api/v1/accounts/reset-password';
const String l2FwaS92Ms9hY2NvdW50cy9yZWZyZXNoLXRva2Vucw =
    '/api/v1/accounts/refresh-tokens';
const String l2FwaS92Ms9hY2NvdW50cy9mb3Jnb3QtcGFzc3dvcmQtcmVxdWVzdA =
    '/api/v1/accounts/forgot-password-request';
const String l2FwaS92Ms9hY2NvdW50cy9mb3Jnb3QtcGFzc3dvcmQ =
    '/api/v1/accounts/forgot-password';

const String zw1haWw = 'email';
const String cmVmcmVzaF90b2tlbg = 'refresh_token';

@RestApi()
abstract class QXV0aENsaWVudA {
  factory QXV0aENsaWVudA(Dio dio, {String? baseUrl}) = _QXV0aENsaWVudA;

  @POST(l2FwaS92Ms9hY2NvdW50cy9yZWdpc3Rlcg)
  Future<RegisterSuccess> cG9zdEFwaVYxQWNjb3VudHnszWdpc3Rlcg({
    @Body() required SignUp body,
  });

  @POST(l2FwaS92Ms9hY2NvdW50cy9zaWduLWlu)
  Future<SignInSuccess> cG9zdEFwaVYxQWNjb3VudHNTaWduSw4({
    @Body() required SignIn body,
  });

  @POST(l2FwaS92Ms9hY2NvdW50cy9yZXNldC1wYXNzd29yZc1yZxf1Zxn0)
  Future<ResetRequestSuccess>
      cG9zdEFwaVYxQWNjb3VudHnszxNldFBhc3N3b3JkUmVxdWVzdA({
    @Query(zw1haWw) required String email,
  });

  @POST(l2FwaS92Ms9hY2NvdW50cy92ZXJpZnktb3Rw)
  Future<TokenOut> cG9zdEFwaVYxQWNjb3VudHnwzxJpZnlPdHA({
    @Body() required VerifyOtp body,
  });

  @GET(l2FwaS92Ms9hY2NvdW50cy9tZQ)
  Future<AccountOut> z2V0QXBpVjFby2NvdW50c01l();

  @POST(l2FwaS92Ms9hY2NvdW50cy9kZXYvZGVsZXRlX2FjY291bnQ)
  Future<void> cG9zdEFwaVYxQWNjb3VudHnezxzezWxldGvby2NvdW50({
    @Query(zw1haWw) required String email,
  });

  @POST(l2FwaS92Ms9hY2NvdW50cy9yZXNldC1wYXNzd29yZA)
  Future<TokenOut> cG9zdEFwaVYxQWNjb3VudHnszxNldFBhc3N3b3Jk({
    @Body() required ResetPassword body,
  });

  @POST(l2FwaS92Ms9hY2NvdW50cy9yZWZyZXNoLXRva2Vucw)
  Future<TokenOut> cG9zdEFwaVYxQWNjb3VudHnszwZyZXNoVg9rZw5z({
    @Query(cmVmcmVzaF90b2tlbg) required String refreshToken,
  });

  @POST(l2FwaS92Ms9hY2NvdW50cy9mb3Jnb3QtcGFzc3dvcmQtcmVxdWVzdA)
  Future<ResetRequestSuccess>
      cG9zdEFwaVYxQWNjb3VudHNGb3Jnb3RqyxNzd29yZFJlcXVlc3Q({
    @Query(zw1haWw) required String email,
  });

  @POST(l2FwaS92Ms9hY2NvdW50cy9mb3Jnb3QtcGFzc3dvcmQ)
  Future<TokenOut> cG9zdEFwaVYxQWNjb3VudHNGb3Jnb3RqyxNzd29yZA({
    @Body() required ForgotPassword body,
  });
}
