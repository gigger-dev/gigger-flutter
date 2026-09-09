import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final VoidCallback onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 26.w),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Image.asset(
            Assets.images.giUserIconEmpty.path,
            width: 20.h,
            height: 20.h,
          ),
        ),
        SizedBox(width: 32.w),
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              color: colorWhite,
              fontSize: 13.sp,
              decoration: TextDecoration.none,
            ),
            onChanged: (_) => onChanged(),
            validator: (v) {
              if (v!.isEmpty) return 'required';

              if (!EmailValidator.validate(v)) {
                return 'invalid email';
              }

              return null;
            },
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(color: colorWhite.withOpacity(0.5)),
              errorStyle: TextStyle(color: colorWhite, fontSize: 13.sp),
              isDense: true,
              suffixIconConstraints: const BoxConstraints(
                minWidth: 2,
                minHeight: 2,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(width: 26.w),
      ],
    );
  }
}
