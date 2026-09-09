import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/availability/providers/availability_controller.dart';
import 'package:mobile_gigger_app/features/availability/widgets/availability_form_sheet.dart';
import 'package:mobile_gigger_app/features/availability/widgets/schedule_item.dart';
import 'package:mobile_gigger_app/models/availability_out.dart';
import 'package:mobile_gigger_app/widgets/custom_switch.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class AvailabilityScreen extends ConsumerStatefulWidget {
  const AvailabilityScreen({
    super.key,
    required this.status,
    required this.viewOnly,
    required this.availability,
  });

  final bool status;
  final bool viewOnly;
  final List<AvailabilityOut> availability;

  @override
  ConsumerState<AvailabilityScreen> createState() =>
      _AvailabilitySetupScreenState();
}

class _AvailabilitySetupScreenState extends ConsumerState<AvailabilityScreen> {
  late bool status;
  late bool viewOnly;

  @override
  void initState() {
    super.initState();
    status = widget.status;
    viewOnly = widget.viewOnly;

    Future.delayed(
      Duration.zero,
      () => ref
          .read(availabilityControllerProvider.notifier)
          .resetData(widget.availability),
    );
  }

  String timeFormat(String time) {
    if (time.isEmpty) return '';

    try {
      var date = DateFormat('hh:mm a').parse(time);
      return DateFormat('hh:mm a').format(date);
    } catch (e) {
      var date = DateFormat('HH:mm').parse(time);
      return DateFormat('hh:mm a').format(DateTime.now().copyWith(
        hour: date.hour,
        minute: date.minute,
        second: 0,
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(availabilityControllerProvider);

    var days = state.items.map((e) => e.day).toSet().toList();
    days.sort();

    return PopScope(
      onPopInvokedWithResult: onPop,
      child: Scaffold(
        backgroundColor: colorRedGradient,
        appBar: AppBar(backgroundColor: colorRedGradient),
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                if (!viewOnly)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: TextViewWidget(
                                text: 'AVAILABILITY\nSETUP PAGE',
                                textSize: 30,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor:
                                        status ? Colors.green : Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextViewWidget(
                                        text: status
                                            ? 'Available!'
                                            : 'Unavailable!',
                                      ),
                                      const SizedBox(height: 10),
                                      const TextViewWidget(
                                        text:
                                            'Customize your week! If you activate it and choose not to set it up you\'ll be always available',
                                        textSize: 14,
                                        height: 1.2,
                                      ),
                                    ],
                                  ),
                                ),
                                CustomSwitch(
                                  value: status,
                                  onChanged: (value) {
                                    status = value;
                                    setState(() {});
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 10),
                        child: SetupItem(
                          showPro: false,
                          icon: Icons.settings,
                          title: 'Setup your daily schedule',
                          onTap: !status ? null : onScheduleTap,
                        ),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextViewWidget(text: 'Quick overview'),
                      const SizedBox(height: 20),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: days.length,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          var day = days[index];
                          var times =
                              state.items.where((e) => e.day == day).toList();

                          times.sort((a, b) {
                            return a.startTime.compareTo(b.startTime);
                          });

                          return ScheduleItem(
                            viewOnly: viewOnly,
                            date: '${dayData[day]}',
                            times: times.map((e) {
                              return [
                                timeFormat(e.startTime),
                                timeFormat(e.endTime)
                              ];
                            }).toList(),
                            onRemove: (i) {
                              ref
                                  .read(availabilityControllerProvider.notifier)
                                  .remove(times[i]);
                            },
                            onTap: onScheduleTap,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                if (!viewOnly)
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      const Center(
                        child: TextViewWidget(
                          text: 'Pro Features (not included):',
                          textSize: 16,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, top: 30, right: 10),
                        child: Column(
                          children: [
                            const Opacity(
                              opacity: .5,
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.only(left: 40),
                                title: TextViewWidget(
                                  text: 'Connected\nAccount(s)',
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextViewWidget(text: 'Select Calendar'),
                                    SizedBox(width: 20),
                                    Icon(CupertinoIcons.right_chevron),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            SetupItem(
                              disable: true,
                              icon: Icons.calendar_month,
                              title: 'Auto Booking from contacts',
                              value: false,
                              onChanged: (value) {},
                            ),
                            const SetupItem(
                              disable: true,
                              icon: Icons.check,
                              title: 'Allow-list',
                              haveArrow: true,
                            ),
                            SetupItem(
                              disable: true,
                              icon: CupertinoIcons.slash_circle_fill,
                              title: 'Temporary Unavailable',
                              value: false,
                              onChanged: (value) {},
                            ),
                            const Opacity(
                              opacity: .5,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 24, top: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    TextViewWidget(text: 'From'),
                                    SizedBox(width: 30),
                                    TextViewWidget(text: 'to'),
                                  ],
                                ),
                              ),
                            ),
                            SetupItem(
                              disable: true,
                              icon: CupertinoIcons.moon,
                              title: 'Do not disturb',
                              value: false,
                              description:
                                  'Will not allow bookings on your free time and notify Users with automated out of office DM message',
                              onChanged: (value) {},
                            ),
                            const SizedBox(height: 30),
                            const SetupItem(
                              disable: true,
                              icon: CupertinoIcons.moon,
                              title: 'Custom out of office message',
                              haveArrow: true,
                              description:
                                  'Activating Temporary unavailable and/or Do not disturb will notify users with your custom message',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: .1.sh),
                    ],
                  )
              ],
            ),
            if (!viewOnly)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: GradientFilledButton(
                    title: 'Save',
                    onPressed: () => onSave(state.items),
                    boxShadow: BoxShadow(
                      color: colorBlack.withOpacity(.6),
                      offset: const Offset(6, 10),
                      blurRadius: 10,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> onScheduleTap() async {
    ref.read(availabilityControllerProvider.notifier).setItemData();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorTransparent,
      builder: (context) => const AvailabilityFormSheet(),
    );
  }

  void onSave(List<AvailabilityOut> items) {
    context.pop([status, items]);
  }

  void onPop(bool didPop, result) {
    if (viewOnly) return;

    if (result == null) {
      Future.delayed(
        Duration(milliseconds: 200),
        () => ref
            .read(availabilityControllerProvider.notifier)
            .resetData(widget.availability),
      );
    }
  }
}

class SetupItem extends StatelessWidget {
  const SetupItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.disable = false,
    this.haveArrow = false,
    this.value,
    this.onChanged,
    this.showPro = true,
    this.description,
  });

  final IconData icon;
  final String title;
  final String? description;
  final VoidCallback? onTap;
  final bool disable;

  final bool showPro;

  final bool haveArrow;
  final bool? value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      enabled: !disable,
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(icon, size: 18),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     Flexible(
                //       child: Opacity(
                //         opacity: disable ? .5 : 1,
                //         child: TextViewWidget(text: title),
                //       ),
                //     ),
                //     if (showPro)
                //       const Padding(
                //         padding: EdgeInsets.only(left: 30),
                //         child: TextViewWidget(text: '- Pro'),
                //       ),
                //   ],
                // ),
                Opacity(
                  opacity: disable ? .5 : 1,
                  child: TextViewWidget(text: title),
                ),
                if (description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Opacity(
                      opacity: disable ? .5 : 1,
                      child: TextViewWidget(
                        text: description!,
                        textSize: 13,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Opacity(
            opacity: disable ? .5 : 1,
            child: _trailingWidget(),
          )
        ],
      ),
    );
  }

  Widget _trailingWidget() {
    if (haveArrow) {
      return const Icon(
        CupertinoIcons.right_chevron,
        color: colorWhite,
        size: 18,
      );
    }

    if (value != null && onChanged != null) {
      return CustomSwitch(value: value!, onChanged: onChanged!);
    }

    return const SizedBox();
  }
}
