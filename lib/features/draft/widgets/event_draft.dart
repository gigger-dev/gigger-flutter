import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/date_format.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/draft/providers/event_draft_controller.dart';
import 'package:mobile_gigger_app/features/draft/widgets/draft_action_btn.dart';
import 'package:mobile_gigger_app/features/event_form/providers/event_form_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/accordian_widget.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/video_delete_sheet.dart';

class EventDraft extends ConsumerWidget {
  const EventDraft({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = ref.watch(eventDraftControllerProvider).valueOrNull ?? [];

    return AccordionWidget(
      title: 'EVENTS DRAFTS',
      content: [
        items.isEmpty
            ? SizedBox(
                height: .2.sh,
                child: Center(
                  child: TextViewWidget(text: 'EMPTY', color: colorGrey),
                ),
              )
            : StaggeredGridView.countBuilder(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                itemCount: items.length,
                physics: NeverScrollableScrollPhysics(),
                staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
                itemBuilder: (context, index) {
                  return EventItem(data: items[index], index: index);
                },
              )
      ],
    );
  }
}

class EventItem extends ConsumerWidget {
  const EventItem({super.key, required this.data, required this.index});

  final int index;
  final EventOut data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: colorGrey,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(File(data.thumbnailUrl)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: colorBtnOrangeRed,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextViewWidget(
                      text: '${data.startTime.toLocal().day}',
                      color: colorWhite,
                      textSize: 14,
                      height: 1,
                    ),
                    TextViewWidget(
                      text: DateFormat.MMM().format(data.startTime.toLocal()),
                      color: colorWhite,
                      textSize: 10,
                      height: 1,
                    ),
                  ],
                ),
              ),
              DraftActionBtn(
                index: index,
                onModifyTap: () => onModifyTap(context, ref),
                onDeleteTap: () => onDeleteTap(context, ref),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: TextViewWidget(
              text: draftDateFormat(data.createdAt),
              color: colorWhite,
              textSize: 11.sp,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  void onModifyTap(BuildContext context, WidgetRef ref) {
    if (data.videoOrImageUrl == data.thumbnailUrl) {
      ref
          .read(eventFormControllerProvider.notifier)
          .thumbnailFile(data.thumbnailUrl);
    } else {
      ref.read(eventFormControllerProvider.notifier).videoData(
            isHori: false,
            video: File(data.videoOrImageUrl),
            thumbnailImg: File(data.thumbnailUrl),
          );
    }

    ref.read(eventFormControllerProvider.notifier).isDraft(true);

    EventFormRoute($extra: data).push(context);
  }

  void onDeleteTap(BuildContext context, WidgetRef ref) {
    SheetUtils.showSimpleSheet(
      context: context,
      child: DeleteSheet(
        confirmText: 'Yes delete my event draft',
        title: 'YOU ARE DELETING THIS DRAFT, ARE YOU SURE?',
        onDelete: () async {
          await ref
              .read(eventDraftControllerProvider.notifier)
              .delete(data.uuid);
          if (context.mounted) context.pop();
        },
      ),
    );
  }
}
