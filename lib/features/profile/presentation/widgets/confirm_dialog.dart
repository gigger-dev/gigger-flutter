import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/outlined_btn.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    this.title,
    this.cancelText,
    this.confirmText,
  });

  final String? title;
  final String? cancelText;
  final String? confirmText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: TextViewWidget(
              text: title ??
                  'YOU ARE LEAVING THE EDITOR WITHOUT SAVING.\nARE YOU SURE?',
              textSize: 23,
              height: 1.2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: .1.sh),
          OutlinedBtn(
            onPressed: () => context.pop(true),
            text: cancelText ?? 'Yes, go back',
          ),
          const SizedBox(height: 14),
          GradientFilledButton(
            title: confirmText ?? 'Continue editing',
            onPressed: () => context.pop(false),
          )
        ],
      ),
    );
  }
}
