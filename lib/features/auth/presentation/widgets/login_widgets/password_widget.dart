import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/validator_utils.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool obscureText = true;

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
            Assets.images.giPswEmptyIcon.path,
            width: 23.h,
            height: 20.h,
          ),
        ),
        SizedBox(width: 32.w),
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            obscureText: obscureText,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            style: TextStyle(color: colorWhite, fontSize: 13.sp),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'required';
              }

              return passwordValidator(value);
            },
            onChanged: (text) => widget.onChanged(),
            decoration: InputDecoration(
              hintText: 'Password',
              errorMaxLines: 3,
              hintStyle: TextStyle(color: colorWhite.withOpacity(0.5)),
              errorStyle: TextStyle(color: colorWhite, fontSize: 12),
              isDense: true,
              suffixIconConstraints:
                  const BoxConstraints(minWidth: 2, minHeight: 2),
              suffixIcon: CupertinoButton(
                minSize: 0,
                padding: EdgeInsets.zero,
                onPressed: () {
                  obscureText = !obscureText;
                  setState(() {});
                },
                child: Icon(
                  obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.white,
                ),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
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
