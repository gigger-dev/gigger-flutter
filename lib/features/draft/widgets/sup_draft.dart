import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/date_format.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/draft/providers/sup_draft_controller.dart';
import 'package:mobile_gigger_app/features/draft/widgets/draft_action_btn.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/accordian_widget.dart';
import 'package:mobile_gigger_app/models/draft_model.dart';
import 'package:mobile_gigger_app/models/post_form_extra.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/video_delete_sheet.dart';

class SupDraft extends ConsumerWidget {
  const SupDraft({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = ref.watch(supDraftControllerProvider).valueOrNull ?? [];

    return AccordionWidget(
      title: 'S\'UP DRAFTS',
      content: [
        items.isEmpty
            ? SizedBox(
                height: .2.sh,
                child: Center(
                  child: TextViewWidget(text: 'EMPTY', color: colorGrey),
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  childAspectRatio: .7,
                ),
                itemBuilder: (context, index) {
                  return SupItem(data: items[index], index: index);
                },
              ),
      ],
    );
  }
}

class SupItem extends ConsumerWidget {
  const SupItem({super.key, required this.data, required this.index});

  final int index;
  final SupDraftModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorGrey,
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(File(data.thumbnailUrl)),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: DraftActionBtn(
              index: index,
              onModifyTap: () => onModifyTap(context, ref),
              onDeleteTap: () => onDeleteTap(context, ref),
            ),
          ),
          Positioned(
            left: 5,
            bottom: 5,
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
    ref.read(postFormControllerProvider.notifier)
      ..type(ContentType.sup)
      ..setSupDataFromDraft(data);

    PostFormRoute(
      uuid: data.uuid,
      place: data.location,
      caption: data.caption,
      $extra: PostFormExtra(hashtags: data.hashtags),
    ).push(context);
  }

  void onDeleteTap(BuildContext context, WidgetRef ref) {
    SheetUtils.showSimpleSheet(
      context: context,
      child: DeleteSheet(
        confirmText: 'Yes delete my sup draft',
        title: 'YOU ARE DELETING THIS DRAFT, ARE YOU SURE?',
        onDelete: () {
          ref.read(supDraftControllerProvider.notifier).delete(data.uuid);
        },
      ),
    );
  }
}
