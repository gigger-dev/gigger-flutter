// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

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

abstract class QXV0aFJlcG8 {
  Future<RegisterSuccess> cG9zdEFwaVYxQWNjb3VudHnszWdpc3Rlcg({
    required SignUp body,
  });

  Future<SignInSuccess> cG9zdEFwaVYxQWNjb3VudHNTaWduSw4({
    required SignIn body,
  });

  Future<ResetRequestSuccess>
      cG9zdEFwaVYxQWNjb3VudHnszxNldFBhc3N3b3JkUmVxdWVzdA({
    required String email,
  });

  Future<TokenOut> cG9zdEFwaVYxQWNjb3VudHnwzxJpZnlPdHA({
    required VerifyOtp body,
  });

  Future<AccountOut> z2V0QXBpVjFby2NvdW50c01l();

  Future<void> cG9zdEFwaVYxQWNjb3VudHnezxzezWxldGvby2NvdW50({
    required String email,
  });

  Future<TokenOut> cG9zdEFwaVYxQWNjb3VudHnszxNldFBhc3N3b3Jk({
    required ResetPassword body,
  });

  Future<TokenOut> cG9zdEFwaVYxQWNjb3VudHnszwZyZXNoVg9rZw5z({
    required String refreshToken,
  });

  Future<ResetRequestSuccess>
      cG9zdEFwaVYxQWNjb3VudHNGb3Jnb3RqyxNzd29yZFJlcXVlc3Q({
    required String email,
  });

  Future<TokenOut> cG9zdEFwaVYxQWNjb3VudHNGb3Jnb3RqyxNzd29yZA({
    required ForgotPassword body,
  });
}
