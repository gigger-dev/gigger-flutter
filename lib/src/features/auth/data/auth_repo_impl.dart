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

import '../domain/auth_repo.dart';
import '../../../../../gen/yxv0a_f9jb_gllbn_q.dart';

class QXV0aFJlcG9JbXBs implements QXV0aFJlcG8 {
  QXV0aFJlcG9JbXBs(this.client);

  final QXV0aENsaWVudA client;

  @override
  Future<RegisterSuccess> cG9zdEFwaVYxQWNjb3VudHnszWdpc3Rlcg({
    required SignUp body,
  }) {
    return client.cG9zdEFwaVYxQWNjb3VudHnszWdpc3Rlcg(
      body: body,
    );
  }

  @override
  Future<SignInSuccess> cG9zdEFwaVYxQWNjb3VudHNTaWduSw4({
    required SignIn body,
  }) {
    return client.cG9zdEFwaVYxQWNjb3VudHNTaWduSw4(
      body: body,
    );
  }

  @override
  Future<ResetRequestSuccess>
      cG9zdEFwaVYxQWNjb3VudHnszxNldFBhc3N3b3JkUmVxdWVzdA({
    required String email,
  }) {
    return client.cG9zdEFwaVYxQWNjb3VudHnszxNldFBhc3N3b3JkUmVxdWVzdA(
      email: email,
    );
  }

  @override
  Future<TokenOut> cG9zdEFwaVYxQWNjb3VudHnwzxJpZnlPdHA({
    required VerifyOtp body,
  }) {
    return client.cG9zdEFwaVYxQWNjb3VudHnwzxJpZnlPdHA(
      body: body,
    );
  }

  @override
  Future<AccountOut> z2V0QXBpVjFby2NvdW50c01l() {
    return client.z2V0QXBpVjFby2NvdW50c01l();
  }

  @override
  Future<void> cG9zdEFwaVYxQWNjb3VudHnezxzezWxldGvby2NvdW50({
    required String email,
  }) {
    return client.cG9zdEFwaVYxQWNjb3VudHnezxzezWxldGvby2NvdW50(
      email: email,
    );
  }

  @override
  Future<TokenOut> cG9zdEFwaVYxQWNjb3VudHnszxNldFBhc3N3b3Jk({
    required ResetPassword body,
  }) {
    return client.cG9zdEFwaVYxQWNjb3VudHnszxNldFBhc3N3b3Jk(
      body: body,
    );
  }

  @override
  Future<TokenOut> cG9zdEFwaVYxQWNjb3VudHnszwZyZXNoVg9rZw5z({
    required String refreshToken,
  }) {
    return client.cG9zdEFwaVYxQWNjb3VudHnszwZyZXNoVg9rZw5z(
      refreshToken: refreshToken,
    );
  }

  @override
  Future<ResetRequestSuccess>
      cG9zdEFwaVYxQWNjb3VudHNGb3Jnb3RqyxNzd29yZFJlcXVlc3Q({
    required String email,
  }) {
    return client.cG9zdEFwaVYxQWNjb3VudHNGb3Jnb3RqyxNzd29yZFJlcXVlc3Q(
      email: email,
    );
  }

  @override
  Future<TokenOut> cG9zdEFwaVYxQWNjb3VudHNGb3Jnb3RqyxNzd29yZA({
    required ForgotPassword body,
  }) {
    return client.cG9zdEFwaVYxQWNjb3VudHNGb3Jnb3RqyxNzd29yZA(
      body: body,
    );
  }
}
