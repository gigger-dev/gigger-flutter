import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/context_extension.dart';
import 'package:mobile_gigger_app/features/profile_setup/widgets/motto_widget.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class MottoEditTextbox extends StatefulWidget {
  const MottoEditTextbox({
    super.key,
    required this.text,
    required this.isEdit,
    required this.onChanged,
    required this.editLabel,
  });

  final String text;
  final bool isEdit;
  final String editLabel;
  final ValueChanged<String> onChanged;

  @override
  State<MottoEditTextbox> createState() => _MottoEditTextboxState();
}

class _MottoEditTextboxState extends State<MottoEditTextbox> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40),
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => focusNode.requestFocus(),
          child: Column(
            children: [
              MottoTextBox(
                focusNode: focusNode,
                text: widget.text,
                isEdit: widget.isEdit,
                autofocus: false,
                onChanged: widget.onChanged,
                onFieldSubmitted: widget.onChanged,
                // key: ValueKey('motto_$isEdit'),
                onTapOutside: () => context.clearFocus(),
              ),
              if (widget.isEdit)
                TextViewWidget(
                  text: widget.editLabel,
                  textSize: 13.sp,
                  color: colorTextRed,
                  fontWeight: FontWeight.bold,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
