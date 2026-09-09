import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';

class TextForm extends StatefulWidget {
  const TextForm({
    super.key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.keyboardType,
    this.errorText,
  });

  final String hintText;
  final bool obscureText;
  final bool readOnly;
  final String? errorText;
  final AssetGenImage icon;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  @override
  State<TextForm> createState() => TextFormState();
}

class TextFormState extends State<TextForm> {
  bool isChanged = false;
  bool obscureText = true;
  late String? errorText;

  @override
  void initState() {
    super.initState();
    errorText = widget.errorText;
  }

  @override
  void didUpdateWidget(covariant TextForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      errorText = widget.errorText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Image.asset(
            widget.icon.path,
            width: 20.w,
            height: 20.h,
          ),
        ),
        SizedBox(width: 32.w),
        Expanded(
          child: TextFormField(
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            controller: widget.controller,
            obscuringCharacter: '*',
            obscureText: widget.obscureText && obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (value) {
              isChanged = false;
              errorText = null;
              setState(() {});
            },
            onSaved: (newValue) {
              isChanged = false;
              errorText = null;
              setState(() {});
            },
            onChanged: (value) {
              isChanged = true;
              setState(() {});
            },
            style: TextStyle(
              color: colorWhite,
              fontSize: 13.sp,
              decoration: TextDecoration.none,
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'required';
              }

              if (widget.validator != null) return widget.validator!(value);

              return null;
            },
            decoration: InputDecoration(
              hintText: '${widget.hintText}*',
              errorText: isChanged ? null : errorText,
              hintStyle: TextStyle(color: colorWhite.withOpacity(0.5)),
              errorStyle: TextStyle(fontSize: 11.sp),
              errorMaxLines: 2,
              suffixIcon: !widget.obscureText
                  ? null
                  : CupertinoButton(
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
                      ),
                    ),
              isDense: true,
              suffixIconConstraints: const BoxConstraints(),
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
      ],
    );
  }
}
