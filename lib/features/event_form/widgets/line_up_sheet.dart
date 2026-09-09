import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/date_extension.dart';
import 'package:mobile_gigger_app/features/event_form/providers/line_up_controller.dart';
import 'package:mobile_gigger_app/features/event_form/widgets/select_time_sheet.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class LineUpSheet extends ConsumerStatefulWidget {
  const LineUpSheet({super.key, this.uuid});

  final String? uuid;

  @override
  ConsumerState<LineUpSheet> createState() => _LineUpSheetState();
}

class _LineUpSheetState extends ConsumerState<LineUpSheet> {
  @override
  Widget build(BuildContext context) {
    var items = ref.watch(lineUpControllerProvider);
    var error = ref.watch(lineUpErrorControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            style: IconButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: context.pop,
            icon: Icon(Icons.clear),
          ),
          SizedBox(height: 10),
          TextViewWidget(
            text: 'LINE UP\nTIME RESUME',
            textSize: 24,
            height: 1.2,
          ),
          SizedBox(height: 10),
          TextViewWidget(
            text: 'Tap to modify performers',
            textSize: 12,
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Expanded(child: SizedBox()),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: TextViewWidget(text: 'From', color: colorWhite),
                      ),
                    ),
                    Expanded(child: TextViewWidget(text: ' ')),
                    Expanded(
                      child: Center(
                        child: TextViewWidget(text: 'To', color: colorWhite),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
          SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            itemCount: items.length,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => SizedBox(height: 10),
            itemBuilder: (context, index) {
              var data = items[index];

              var from = DateFormat('HH:mm').tryFormat(data.from);
              var to = DateFormat('HH:mm').tryFormat(data.to);

              var isDisable = widget.uuid != null && data.uuid != widget.uuid;

              return Row(
                children: [
                  Expanded(child: TextViewWidget(text: data.title)),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Expanded(
                            child: CupertinoButton(
                              minSize: 0,
                              padding: EdgeInsets.zero,
                              onPressed: isDisable
                                  ? null
                                  : () => fromTap(
                                        to: data.to,
                                        min: data.min,
                                        max: data.max,
                                        from: data.from,
                                        uuid: data.uuid,
                                      ),
                              child: Center(
                                child: TextViewWidget(
                                  text: from ?? 'Select',
                                  color: isDisable ? Colors.white30 : null,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: TextViewWidget(
                                text: ':',
                                color: isDisable ? Colors.white30 : null,
                              ),
                            ),
                          ),
                          Expanded(
                            child: CupertinoButton(
                              minSize: 0,
                              padding: EdgeInsets.zero,
                              onPressed: isDisable
                                  ? null
                                  : () => toTap(
                                        to: data.to,
                                        min: data.min,
                                        max: data.max,
                                        from: data.from,
                                        uuid: data.uuid,
                                      ),
                              child: Center(
                                child: TextViewWidget(
                                  text: to ?? 'Select',
                                  color: isDisable ? Colors.white30 : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: colorRed, size: 12),
                  SizedBox(width: 4),
                  Expanded(
                    child: TextViewWidget(
                      text: error,
                      color: colorRed,
                      textSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 40),
          GradientFilledButton(title: 'Done', onPressed: onDone)
        ],
      ),
    );
  }

  Future<void> fromTap({
    required String uuid,
    required DateTime? to,
    required DateTime? from,
    required DateTime? min,
    required DateTime? max,
  }) async {
    ref.read(lineUpErrorControllerProvider.notifier).clear();

    var time =
        await onTap(from: from, to: to, isFrom: true, min: min, max: max);
    if (time == null) return;

    ref.read(lineUpControllerProvider.notifier).from(uuid, time);
  }

  Future<void> toTap({
    required String uuid,
    required DateTime? to,
    required DateTime? from,
    required DateTime? min,
    required DateTime? max,
  }) async {
    if (from == null) return;

    ref.read(lineUpErrorControllerProvider.notifier).clear();

    var time =
        await onTap(from: from, to: to, isFrom: false, min: min, max: max);
    if (time == null) return;

    if (from.compareTo(time) != -1) {
      ref
          .read(lineUpErrorControllerProvider.notifier)
          .update('End time must be after start time');
      return;
    }

    ref.read(lineUpControllerProvider.notifier).to(uuid, time);
  }

  Future<DateTime?> onTap({
    required bool isFrom,
    required DateTime? to,
    required DateTime? min,
    required DateTime? max,
    required DateTime? from,
  }) async {
    DateTime? selectedTime;

    if (isFrom) {
      selectedTime = from;
    } else {
      selectedTime = to ?? from?.add(Duration(minutes: 5));
    }

    var time = await showModalBottomSheet<DateTime>(
      context: context,
      isDismissible: true,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: colorTransparent,
      constraints: BoxConstraints(maxHeight: .65.sh),
      builder: (context) => SelectTimeSheet(
        maximumDate: isFrom ? to : max,
        minimumDate: isFrom ? min : from,
        selectedTime: selectedTime ?? DateTime.now().copyWith(minute: 0),
      ),
    );

    if (time == null || !context.mounted) return null;

    return DateTime.now().copyWith(hour: time.hour, minute: time.minute);
  }

  void onDone() {
    var isEmpty = ref
        .read(lineUpControllerProvider)
        .any((e) => e.from == null || e.to == null);

    if (isEmpty) {
      ref
          .read(lineUpErrorControllerProvider.notifier)
          .update('Please select both start and end time');
      return;
    }

    ref.read(lineUpControllerProvider.notifier).done();
    context.pop();
  }
}

class _TimeBox extends StatelessWidget {
  const _TimeBox({
    required this.value,
    required this.onTap,
    this.enabled = true,
    this.hintText,
  });

  final bool enabled;
  final DateTime? value;
  final String? hintText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        onTap: onTap,
        readOnly: true,
        enabled: enabled,
        controller: TextEditingController(
          text: DateFormat('hh:mm a').tryFormat(value),
        ),
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          contentPadding: EdgeInsets.all(4),
          prefixIcon: Icon(Icons.calendar_month),
          prefixIconConstraints: BoxConstraints(minWidth: 30),
        ),
      ),
    );
  }
}
