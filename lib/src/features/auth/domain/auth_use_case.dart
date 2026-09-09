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

import 'auth_repo.dart';

Future<RegisterSuccess> postApiV1AccountsRegisterUseCase({
  required SignUp body,
  required QXV0aFJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxQWNjb3VudHnszWdpc3Rlcg(
    body: body,
  );
}

Future<SignInSuccess> postApiV1AccountsSignInUseCase({
  required SignIn body,
  required QXV0aFJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxQWNjb3VudHNTaWduSw4(
    body: body,
  );
}

Future<ResetRequestSuccess> postApiV1AccountsResetPasswordRequestUseCase({
  required String email,
  required QXV0aFJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxQWNjb3VudHnszxNldFBhc3N3b3JkUmVxdWVzdA(
    email: email,
  );
}

Future<TokenOut> postApiV1AccountsVerifyOtpUseCase({
  required VerifyOtp body,
  required QXV0aFJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxQWNjb3VudHnwzxJpZnlPdHA(
    body: body,
  );
}

Future<AccountOut> getApiV1AccountsMeUseCase(
  QXV0aFJlcG8 repo,
) {
  return repo.z2V0QXBpVjFby2NvdW50c01l();
}

Future<void> postApiV1AccountsDevDeleteAccountUseCase({
  required String email,
  required QXV0aFJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxQWNjb3VudHnezxzezWxldGvby2NvdW50(
    email: email,
  );
}

Future<TokenOut> postApiV1AccountsResetPasswordUseCase({
  required ResetPassword body,
  required QXV0aFJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxQWNjb3VudHnszxNldFBhc3N3b3Jk(
    body: body,
  );
}

Future<TokenOut> postApiV1AccountsRefreshTokensUseCase({
  required String refreshToken,
  required QXV0aFJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxQWNjb3VudHnszwZyZXNoVg9rZw5z(
    refreshToken: refreshToken,
  );
}

Future<ResetRequestSuccess> postApiV1AccountsForgotPasswordRequestUseCase({
  required String email,
  required QXV0aFJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxQWNjb3VudHNGb3Jnb3RqyxNzd29yZFJlcXVlc3Q(
    email: email,
  );
}

Future<TokenOut> postApiV1AccountsForgotPasswordUseCase({
  required ForgotPassword body,
  required QXV0aFJlcG8 repo,
}) {
  return repo.cG9zdEFwaVYxQWNjb3VudHNGb3Jnb3RqyxNzd29yZA(
    body: body,
  );
}
