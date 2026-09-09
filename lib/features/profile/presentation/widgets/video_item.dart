import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_draft_layout_controller.dart';
import 'package:mobile_gigger_app/features/video_player/providers/video_controller.dart';
import 'package:mobile_gigger_app/models/post_form_extra.dart';
import 'package:mobile_gigger_app/widgets/popup_btn.dart';
import 'package:mobile_gigger_app/widgets/video_delete_sheet.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class VideoItem extends ConsumerWidget {
  const VideoItem({
    super.key,
    required this.index,
    required this.data,
    required this.cdnUrl,
    required this.items,
    required this.onDelete,
    required this.isEditMode,
    required this.isOwner,
    required this.uuid,
    required this.allItems,
  });

  final int index;
  final PostOut data;
  final String? cdnUrl;
  final bool isEditMode;
  final bool isOwner;
  final String uuid;
  final List<PostOut> items;
  final List<PostOut> allItems;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var child = Stack(
      children: [
        GestureDetector(
          onTap: isEditMode
              ? null
              : () {
                  ref
                      .read(videoControllerProvider.notifier)
                      .items(allItems, current: index);
                  VideoPlayerRoute(index: index).push(context);
                },
          child: VideoContainer(
            cdnUrl: cdnUrl,
            viewCount: data.viewCount,
            thumbnailUrl: data.thumbnailUrl,
          ),
        ),
        if (isOwner)
          if (isEditMode) ...[
            Positioned.fill(
              child: Container(
                color: Colors.black38,
                child: Icon(CupertinoIcons.move),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: PopupBtn(
                items: [
                  PopupItem(title: 'Edit', onTap: () => onEdit(ref, context)),
                  PopupItem(
                    title: 'Delete',
                    onTap: () => showDeleteSheet(context),
                  ),
                ],
              ),
            ),
          ]
      ],
    );

    if (!isEditMode || !isOwner) return child;

    return LongPressDraggable<String>(
      data: data.uuid,
      rootOverlay: true,
      delay: Duration(milliseconds: 300),
      feedback: SizedBox(
        height: .2.sh,
        width: .24.sw,
        child: VideoContainer(
          cdnUrl: cdnUrl,
          viewCount: data.viewCount,
          thumbnailUrl: data.thumbnailUrl,
        ),
      ),
      childWhenDragging: Opacity(
        opacity: .2,
        child: VideoContainer(
          cdnUrl: cdnUrl,
          viewCount: data.viewCount,
          thumbnailUrl: data.thumbnailUrl,
        ),
      ),
      child: DragTarget<String>(
        onAcceptWithDetails: (details) {
          final oldIndex = allItems.indexWhere((e) => e.uuid == details.data);
          final newIndex = allItems.indexWhere((e) => e.uuid == data.uuid);

          ref.read(fabDraftLayoutControllerProvider(uuid).notifier).move(
                oldIndex: oldIndex,
                newIndex: newIndex,
              );
        },
        builder: (context, _, __) {
          return child;
        },
      ),
    );
  }

  void onEdit(WidgetRef ref, BuildContext context) {
    ref.read(postFormControllerProvider.notifier)
      ..type(ContentType.post)
      ..latLngFrom(data.lat, data.long)
      ..videoUrl(
        videoUrl: data.videoUrl,
        thumbnailImageUrl: data.thumbnailUrl,
      );

    if (!context.mounted) return;

    PostFormRoute(
      uuid: data.uuid,
      place: data.location,
      caption: data.caption,
      title: data.postTitle,
      musicTitle: data.musicTitle,
      $extra: PostFormExtra(hashtags: data.hashtags),
    ).go(context);
  }

  void showDeleteSheet(BuildContext context) {
    SheetUtils.showSimpleSheet(
      context: context,
      child: DeleteSheet(onDelete: onDelete),
    );
  }
}

class VideoContainer extends ConsumerWidget {
  const VideoContainer({
    super.key,
    required this.cdnUrl,
    required this.thumbnailUrl,
    required this.viewCount,
  });

  final int viewCount;
  final String? cdnUrl;
  final String thumbnailUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: colorGrey,
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider('$cdnUrl/$thumbnailUrl'),
        ),
      ),
      padding: EdgeInsets.only(left: 4, bottom: 2),
      alignment: Alignment.bottomLeft,
      child: TextViewWidget(
        text: '$viewCount view${viewCount > 1 ? 's' : ''}',
        color: colorWhite,
        textSize: 12.sp,
      ),
    );
  }
}
