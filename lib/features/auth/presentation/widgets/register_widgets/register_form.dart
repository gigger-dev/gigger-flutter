import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/utils/validator_utils.dart';
import 'package:mobile_gigger_app/features/auth/presentation/widgets/register_widgets/text_form.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

typedef ErrorGetter = String? Function(String name);

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.birthday,
    required this.onBirthdayTap,
    required this.errorGetter,
  });

  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final TextEditingController birthday;
  final VoidCallback onBirthdayTap;
  final ErrorGetter errorGetter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextForm(
          hintText: 'Username',
          controller: username,
          icon: Assets.images.giUserIconEmpty,
          errorText: errorGetter('username'),
          validator: (v) => v!.length < 4 ? 'minimum 4 chars' : null,
        ),
        SizedBox(height: 20.h),
        TextForm(
          hintText: 'Mail',
          controller: email,
          icon: Assets.images.giMailIcon,
          errorText: errorGetter('email'),
          keyboardType: TextInputType.emailAddress,
          validator: (v) =>
              !EmailValidator.validate(v!) ? 'Invalid email' : null,
        ),
        SizedBox(height: 20.h),
        TextForm(
          hintText: 'Password',
          obscureText: true,
          controller: password,
          icon: Assets.images.giPswEmptyIcon,
          errorText: errorGetter('password'),
          validator: (v) => passwordValidator(v!),
        ),
        SizedBox(height: 20.h),
        TextForm(
          obscureText: true,
          hintText: 'Confirm Password',
          controller: confirmPassword,
          icon: Assets.images.giGroupTwoKey,
          errorText: errorGetter('confirm_password'),
          validator: (v) =>
              v != password.text ? 'Password does not match' : null,
        ),
        SizedBox(height: 20.h),
        TextForm(
          readOnly: true,
          controller: birthday,
          hintText: 'Your Birthday',
          icon: Assets.images.giCakeBirthday,
          errorText: errorGetter('dob'),
          onTap: onBirthdayTap,
        ),
      ],
    );
  }
}
