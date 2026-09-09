import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/date_format.dart';
import 'package:mobile_gigger_app/core/utils/get_giglist_thumbnail_url.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/draft/providers/giglist_draft_controller.dart';
import 'package:mobile_gigger_app/features/draft/widgets/draft_action_btn.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/accordian_widget.dart';
import 'package:mobile_gigger_app/models/draft_model.dart';
import 'package:mobile_gigger_app/models/post_form_extra.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:mobile_gigger_app/widgets/video_delete_sheet.dart';

class GiglistDraft extends ConsumerWidget {
  const GiglistDraft({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = ref.watch(giglistDraftControllerProvider).valueOrNull ?? [];

    return AccordionWidget(
      title: 'GIGLIST DRAFTS',
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
                  return GiglistItem(items[index], index);
                },
              )
      ],
    );
  }
}

class GiglistItem extends ConsumerWidget {
  const GiglistItem(this.data, this.index, {super.key});

  final int index;
  final GigListDraftModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: colorGrey,
        borderRadius: BorderRadius.circular(14),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(File(
            getGiglistThumbnailUrl(
              thumbnailUrl: data.thumbnailUrl,
              gigListMedia: data.gigListMedia,
            ),
          )),
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
                  border: Border.all(color: colorWhite),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(6),
                child: TextViewWidget(
                  text: data.isLookingFor ? 'I look for' : 'I offer',
                  textSize: 8,
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
    ref.read(postFormControllerProvider.notifier)
      ..type(ContentType.giglist)
      ..latLngFrom(data.lat, data.long)
      ..setGiglistDataFromDraft(data);

    PostFormRoute(
      uuid: data.uuid,
      title: data.title,
      place: data.location,
      caption: data.description,
      $extra: PostFormExtra(hashtags: data.hashtags),
    ).push(context);
  }

  void onDeleteTap(BuildContext context, WidgetRef ref) {
    SheetUtils.showSimpleSheet(
      context: context,
      child: DeleteSheet(
        confirmText: 'Yes delete my giglist draft',
        title: 'YOU ARE DELETING THIS DRAFT, ARE YOU SURE?',
        onDelete: () {
          ref.read(giglistDraftControllerProvider.notifier).delete(data.uuid);
        },
      ),
    );
  }
}
