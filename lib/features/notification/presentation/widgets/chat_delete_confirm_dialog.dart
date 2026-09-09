import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/helpers/dialog_helper.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/outlined_btn.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatDeleteConfirmDialog extends StatelessWidget {
  const ChatDeleteConfirmDialog(this.channel, {super.key});

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 1.sw,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: TextViewWidget(
                text: 'ARE YOU SURE YOU WANT TO\nDELETE THIS CONVERSATION?',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 40),
          OutlinedBtn(
            onPressed: () async {
              DialogHelper.showOverlay(context);

              try {
                await channel.hide();

                if (!context.mounted) return;

                DialogHelper.hideLoading(context);

                context.pop();
              } catch (e, _) {
                DialogHelper.hideLoading(context);

                Toast.error(e.toString());
              }
            },
            text: 'Delete conversation',
          ),
          const SizedBox(height: 10),
          GradientFilledButton(
            title: 'Cancel',
            onPressed: () => context.pop(),
          ),
        ],
      ),
    );
  }
}
