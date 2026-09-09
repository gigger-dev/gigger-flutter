import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/utils/validator_utils.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/register_widgets/text_form.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

class NewPasswordWidget extends StatelessWidget {
  const NewPasswordWidget({
    super.key,
    required this.password,
    required this.confirmPassword,
  });

  final TextEditingController password;
  final TextEditingController confirmPassword;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        TextForm(
          obscureText: true,
          hintText: 'New Password',
          controller: password,
          icon: Assets.images.giPswEmptyIcon,
          validator: (v) => passwordValidator(v!),
        ),
        SizedBox(height: 20.h),
        TextForm(
          obscureText: true,
          hintText: 'Confirm Password',
          controller: confirmPassword,
          icon: Assets.images.giGroupTwoKey,
          validator: (v) =>
              v != password.text ? 'Password does not match' : null,
        ),
      ],
    );
  }
}
