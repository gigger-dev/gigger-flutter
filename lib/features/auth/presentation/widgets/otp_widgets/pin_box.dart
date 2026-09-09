import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:pinput/pinput.dart';

class PinBox extends StatefulWidget {
  const PinBox({
    super.key,
    required this.otp,
    required this.errorOb,
  });

  final String? errorOb;
  final TextEditingController otp;

  @override
  State<PinBox> createState() => _PinBoxState();
}

class _PinBoxState extends State<PinBox> {
  String? errorOb;

  @override
  void initState() {
    super.initState();
    errorOb = widget.errorOb;
  }

  @override
  void didUpdateWidget(covariant PinBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.errorOb != widget.errorOb) {
      errorOb = widget.errorOb;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Pinput(
          length: 6,
          controller: widget.otp,
          validator: (v) => v!.isEmpty
              ? 'required'
              : v.length < 6
                  ? 'invalid'
                  : null,
          onChanged: (value) {
            errorOb = null;
            setState(() {});
          },
          defaultPinTheme: PinTheme(
            width: 56,
            height: 56,
            textStyle: const TextStyle(
              fontSize: 20,
              color: colorWhite,
              fontWeight: FontWeight.w600,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: colorWhite),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        if (errorOb != null)
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 42.w),
                Image.asset(
                  Assets.images.giInformation.path,
                  width: 20.h,
                  height: 20.h,
                ),
                SizedBox(width: 20.w),
                TextViewWidget(
                  text: errorOb!,
                  color: colorWhite,
                  textSize: 13.sp,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
