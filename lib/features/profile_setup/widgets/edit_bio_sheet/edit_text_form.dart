import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class EditTextForm extends StatelessWidget {
  const EditTextForm({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.identifier,
    this.maxLength,
    this.maxLines = 1,
  });

  final String label;
  final String hintText;
  final String? identifier;
  final int? maxLength;
  final int? maxLines;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    var border = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextViewWidget(
          text: label,
          textSize: 15,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 4),
        Semantics(
          identifier: identifier,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onTapOutside: (_) => context.clearFocus(),
            style: TextStyle(
              color: colorWhite,
              fontSize: 13.sp,
              decoration: TextDecoration.none,
            ),
            maxLength: maxLength,
            maxLines: maxLines,
            validator: (v) => v!.isEmpty ? 'required' : null,
            decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
              errorBorder: border,
              enabledBorder: border,
              focusedBorder: border,
              focusedErrorBorder: border,
              errorStyle: TextStyle(fontSize: 13.sp),
              hintStyle: TextStyle(color: colorWhite.withOpacity(0.5)),
              suffixIconConstraints: BoxConstraints(minWidth: 2, minHeight: 2),
            ),
          ),
        ),
      ],
    );
  }
}
