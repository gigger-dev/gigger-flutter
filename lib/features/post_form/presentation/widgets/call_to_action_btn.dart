import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/post_form_screen.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/call_to_action_sheet.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class CallToActionBtn extends ConsumerWidget {
  const CallToActionBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(postFormControllerProvider);

    return PostListTile(
      value: state.addCallToAction,
      title: 'Add Call to Action Button',
      subtitle: !state.addCallToAction
          ? 'Customize action on your classified'
          : '"${state.callToAction.name}" added.',
      onChanged: (v) async {
        var data = await SheetUtils.showSheet<Map<String, dynamic>>(
          context: context,
          isScrollControlled: true,
          title: TextViewWidget(text: 'Add Call to Action'),
          actionPadding: EdgeInsets.only(top: 20, left: 10),
          children: [
            SizedBox(
              height: .7.sh,
              child: CallToActionSheet(
                state.addCallToAction,
                state.callToAction,
              ),
            )
          ],
        );

        if (data == null) return;

        var groupValue = data['groupValue'] as int;
        var name = data['name'] as String;
        var url = data['url'] as String;
        var title = data['title'] as String;
        var desc = data['desc'] as String;

        ref
            .read(postFormControllerProvider.notifier)
            .addCallToAction(name, url, title, desc, groupValue);
      },
    );
  }
}
