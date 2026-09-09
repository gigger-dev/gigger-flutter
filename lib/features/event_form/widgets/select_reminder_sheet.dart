import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SelectReminderSheet extends ConsumerStatefulWidget {
  const SelectReminderSheet({super.key, this.duration});

  final Duration? duration;

  @override
  ConsumerState<SelectReminderSheet> createState() =>
      _SelectReminderSheetState();
}

class _SelectReminderSheetState extends ConsumerState<SelectReminderSheet> {
  int? day;
  Duration? duration;

  @override
  void initState() {
    super.initState();
    duration = widget.duration;
    day = duration?.inDays;
    if (day != null && day! > 0) {
      duration = duration! - Duration(days: day!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: context.pop,
              child: Image.asset(
                Assets.images.closeIcon.path,
                color: colorWhite,
                width: 25,
                height: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextViewWidget(
                        text: 'SELECT YOUR\nREMINDER',
                        textSize: 30.sp,
                        height: 1,
                      ),
                      SizedBox(height: 10),
                      TextViewWidget(
                        text: 'Send a notification before the event:',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 220,
                        child: Stack(
                          children: [
                            CupertinoPicker(
                              itemExtent: 36,
                              scrollController: FixedExtentScrollController(
                                initialItem: day ?? 0,
                              ),
                              onSelectedItemChanged: (value) {
                                day = value;
                                setState(() {});
                              },
                              children: List<Widget>.generate(32, (int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 34),
                                  child: Semantics(
                                    child: Text(
                                      '$index',
                                      style: TextStyle(fontSize: 26),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'days',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: colorWhite,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CupertinoTimerPicker(
                        initialTimerDuration: duration ?? Duration.zero,
                        mode: CupertinoTimerPickerMode.hm,
                        onTimerDurationChanged: (value) {
                          duration = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GradientFilledButton(title: 'Done', onPressed: onDone),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void onDone() {
    var duration = Duration(days: day ?? 0) + (this.duration ?? Duration.zero);
    context.pop(duration.inSeconds == 0 ? null : duration);
  }
}
