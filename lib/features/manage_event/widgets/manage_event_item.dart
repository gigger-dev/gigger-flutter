import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/helpers/dialog_helper.dart';
import 'package:mobile_gigger_app/core/helpers/event_helper.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/get_share_url.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/event_form/providers/event_form_controller.dart';
import 'package:mobile_gigger_app/features/event_form/providers/reminder_controller.dart';
import 'package:mobile_gigger_app/features/event_form/widgets/select_reminder_sheet.dart';
import 'package:mobile_gigger_app/features/home/providers/event_controller.dart';
import 'package:mobile_gigger_app/features/home/providers/self_event_controller.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:mobile_gigger_app/widgets/popover_item.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:mobile_gigger_app/widgets/video_delete_sheet.dart';
import 'package:popover/popover.dart';
import 'package:share_plus/share_plus.dart';

class ManageEventItem extends ConsumerStatefulWidget {
  const ManageEventItem(this.items, this.index, {super.key});

  final int index;
  final List<EventOut> items;

  @override
  ConsumerState<ManageEventItem> createState() => _ManageEventItemState();
}

class _ManageEventItemState extends ConsumerState<ManageEventItem> {
  late EventOut data;

  @override
  void initState() {
    super.initState();
    data = widget.items[widget.index];
  }

  @override
  void didUpdateWidget(covariant ManageEventItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      data = widget.items[widget.index];
    }
  }

  @override
  Widget build(BuildContext context) {
    var isReminder =
        ref.watch(isReminderProvider(data.uuid)).valueOrNull ?? false;

    var isExpired = data.endTime.toLocal().isBefore(DateTime.now());

    return ListTile(
      dense: true,
      minLeadingWidth: 0,
      onTap: onTap,
      leading: Column(
        children: [
          SizedBox(height: 12.sp),
          CircleAvatar(radius: 3, backgroundColor: colorWhite),
        ],
      ),
      title: TextViewWidget(
        text: data.name,
        color: isExpired ? colorTextGrey : colorRed,
      ),
      subtitle: TextViewWidget(
        text: DateFormat('EEE dd MMMM yyyy hh:mma')
            .format(data.startTime.toLocal()),
        textSize: 10.sp,
        color: isExpired ? colorTextGrey : colorRed,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isReminder)
            IconButton(
              onPressed: onRemoveReminder,
              icon: Transform.rotate(
                angle: .5,
                child: Icon(CupertinoIcons.bell_fill, color: colorRed),
              ),
            ),
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => showPopover(
                  width: 100,
                  radius: 10,
                  context: context,
                  direction: PopoverDirection.left,
                  backgroundColor: colorTextRed,
                  bodyBuilder: (context) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PopoverItem(
                          title: 'Modify',
                          onTap: () =>
                              EventFormRoute($extra: data).push(context),
                        ),
                        PopoverItem(
                          title: 'Delete',
                          onTap: () => SheetUtils.showSimpleSheet(
                            context: context,
                            child: DeleteSheet(
                              onDelete: () => onDelete(context, ref),
                              confirmText: 'Yes delete my event',
                              title:
                                  'YOU ARE DELETING THIS EVENT, ARE YOU SURE?',
                            ),
                          ),
                        ),
                        PopoverItem(
                          title: 'Share',
                          onTap: () => Share.share(
                            'Check out this event ${getEventShareUrl(data.uuid)}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                icon: Icon(Icons.more_vert, color: colorWhite),
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> onDelete(BuildContext context, WidgetRef ref) async {
    try {
      DialogHelper.showOverlay(context);

      await ref.read(eventFormControllerProvider.notifier).delete(data.uuid);
      ref.read(selfEventControllerProvider.notifier).refresh();
      ref.read(eventControllerProvider.notifier).refresh();

      if (!context.mounted) return;
      DialogHelper.hideLoading(context);

      MainRoute().go(context);
    } catch (e) {
      DialogHelper.hideLoading(context);
    }
  }

  Future<void> onRemoveReminder() async {
    await EventHelper.deleteEvent(data.uuid);

    Toast.success('Event reminder removed');
  }

  Future<void> onAddReminder() async {
    await EventHelper.requestPermission();

    if (!mounted) return;

    var duration = await SheetUtils.showSimpleSheet<Duration>(
      context: context,
      isScrollControlled: true,
      child: SelectReminderSheet(),
    );

    if (duration == null) return;

    await EventHelper.createEvent(
      name: data.name,
      reminder: duration,
      eventId: data.uuid,
      location: data.location,
      description: data.description,
      endTime: data.endTime.toLocal(),
      startTime: data.startTime.toLocal(),
    );

    Toast.success('Event reminder added');

    ref.read(isReminderProvider(data.uuid).notifier).refresh();
  }

  void onTap() {
    ref.read(eventControllerProvider.notifier);
    EventScrollRoute(index: widget.index, $extra: widget.items).push(context);
  }
}
