import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/extension/date_extension.dart';
import 'package:mobile_gigger_app/features/availability/providers/availability_controller.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';

var dayData = {
  1: 'Mon',
  2: 'Tue',
  3: 'Wed',
  4: 'Thu',
  5: 'Fri',
  6: 'Sat',
  7: 'Sun'
};

class AvailabilityFormSheet extends ConsumerWidget {
  const AvailabilityFormSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(availabilityControllerProvider);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (result == null) {
          ref.read(availabilityControllerProvider.notifier).cancel();
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.zero,
              onPressed: context.pop,
              child: const Icon(Icons.clear, color: colorWhite),
            ),
            const SizedBox(height: 20),
            const TextViewWidget(text: 'Tap on week day and pick the time'),
            const SizedBox(height: 20),
            Row(
              children: dayData.keys.map((e) {
                // var isSaved = state.days.contains(e);
                var isSelected = state.selected.keys.contains(e);

                var isModify = state.items.any((i) => i.day == e);

                return Expanded(
                  child: InkWell(
                    onTap: () {
                      if (isSelected) {
                        ref
                            .read(availabilityControllerProvider.notifier)
                            .removeDay(e);
                      } else {
                        ref
                            .read(availabilityControllerProvider.notifier)
                            .addDay(e);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isModify && !isSelected
                            ? colorRed
                            : isSelected
                                ? colorWhite
                                : null,
                        border: isModify || isSelected
                            ? null
                            : Border.all(color: colorWhite),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      child: TextViewWidget(
                        text: dayData[e]!,
                        textSize: 11,
                        color: isSelected ? colorBlack : null,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Container(
              decoration: BoxDecoration(
                color: colorBlack1A,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Expanded(child: TextViewWidget(text: 'From')),
                      SizedBox(width: 20),
                      Expanded(child: TextViewWidget(text: 'To')),
                      SizedBox(width: 40),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.selectedTimes.length,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      var data = state.selectedTimes[index];

                      return Opacity(
                        opacity: state.selected.keys.isEmpty ? .5 : 1,
                        child: Row(
                          children: [
                            _TimeBox(
                              value: data.from,
                              enabled: data.isNew,
                              onTap: () async {
                                if (state.selected.keys.isEmpty) return;

                                var time = await onTap(
                                  context,
                                  data.from ??
                                      DateTime.now()
                                          .copyWith(hour: 9, minute: 0),
                                );

                                if (time == null) return;

                                ref
                                    .read(
                                        availabilityControllerProvider.notifier)
                                    .setTime(index: index, from: time);
                              },
                            ),
                            const SizedBox(width: 20),
                            _TimeBox(
                              value: data.to,
                              enabled: data.isNew,
                              onTap: () async {
                                if (state.selected.keys.isEmpty) return;

                                var time = await onTap(
                                  context,
                                  data.to ??
                                      DateTime.now()
                                          .copyWith(hour: 17, minute: 0),
                                );

                                if (time == null) return;

                                if (data.from?.compareTo(time) != -1) {
                                  Toast.error(
                                      'End time must be after start time');
                                  return;
                                }

                                ref
                                    .read(
                                        availabilityControllerProvider.notifier)
                                    .setTime(
                                      index: index,
                                      to: time,
                                      from: data.from,
                                    );
                              },
                            ),
                            const SizedBox(width: 20),
                            !data.isNew
                                ? SizedBox(width: 24)
                                : CupertinoButton(
                                    minSize: 0,
                                    onPressed: () {
                                      ref
                                          .read(availabilityControllerProvider
                                              .notifier)
                                          .removeTime(data);
                                    },
                                    padding: EdgeInsets.zero,
                                    child: const Icon(Icons.clear,
                                        color: colorRed),
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: state.selected.keys.isEmpty
                  ? null
                  : () {
                      ref
                          .read(availabilityControllerProvider.notifier)
                          .addTime();
                    },
              child: Opacity(
                opacity: state.selected.keys.isEmpty ? .5 : 1,
                child: const Center(child: TextViewWidget(text: 'Add')),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    ref
                        .read(availabilityControllerProvider.notifier)
                        .clearDays();
                  },
                  child:
                      const TextViewWidget(text: 'Reset day', color: colorRed),
                ),
                SizedBox(
                  width: 120,
                  child: GradientFilledButton(
                    onPressed: () => onConfirmTap(context, state, ref),
                    title: 'Confirm',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> onTap(BuildContext context, DateTime value) async {
    TimeOfDay? day = await showModalBottomSheet(
      context: context,
      isDismissible: true,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: colorTransparent,
      constraints: BoxConstraints(maxHeight: .65.sh),
      builder: (context) => TimePickerTheme(
        data: TimePickerThemeData(
          backgroundColor: colorBlack,
          dayPeriodColor: Colors.grey.shade900,
          hourMinuteColor: Colors.grey.shade900,
          dialBackgroundColor: Colors.grey.shade900,
        ),
        child: TimePickerDialog(
          initialTime: TimeOfDay.fromDateTime(value),
        ),
      ),
    );

    if (day == null || !context.mounted) return null;

    return DateTime.now().copyWith(hour: day.hour, minute: day.minute);
  }

  void onConfirmTap(
    BuildContext context,
    AvailabilityState state,
    WidgetRef ref,
  ) {
    if (state.selected.isEmpty) {
      Toast.error('Please select at least one day');
      return;
    }

    if (state.selected.values.any((e) => e.isEmpty)) {
      Toast.error('Please select at least one time');
      return;
    }

    if (state.selected.values
        .any((e) => e.any((e) => e.from == null || e.to == null))) {
      Toast.error('Please select both start and end time');
      return;
    }

    ref.read(availabilityControllerProvider.notifier).save();

    context.pop(true);
  }
}

class _TimeBox extends StatelessWidget {
  const _TimeBox({
    required this.value,
    required this.onTap,
    this.enabled = true,
  });

  final bool enabled;
  final DateTime? value;
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
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(4),
          prefixIcon: Icon(Icons.calendar_month),
          prefixIconConstraints: BoxConstraints(minWidth: 30),
        ),
      ),
    );
  }
}
