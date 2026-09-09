import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/fab_draft_layout_controller.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/custom_animated_slider.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/fab_six_video.dart';
import 'package:mobile_gigger_app/features/profile/presentation/widgets/video_item.dart';
import 'package:mobile_gigger_app/features/video_player/providers/video_controller.dart';
import 'package:mobile_gigger_app/models/post_form_extra.dart';
import 'package:mobile_gigger_app/widgets/popup_btn.dart';
import 'package:mobile_gigger_app/widgets/video_delete_sheet.dart';
import 'package:mobile_gigger_app/models/post_out.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class FabThreeVideo extends ConsumerWidget {
  const FabThreeVideo({
    super.key,
    required this.cdnUrl,
    required this.items,
    required this.onDelete,
    required this.isEditMode,
    required this.isOwner,
    required this.uuid,
  });

  final String cdnUrl;

  final bool isEditMode;
  final bool isOwner;
  final List<PostOut> items;
  final ValueChanged<String> onDelete;

  final String uuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (items.length < 6) return SizedBox();

    var _items = items.sublist(6, items.length);

    return CustomAnimatedSlider(
      isLoop: false,
      initialPage: 0,
      isMoved: false,
      showIndicator: false,
      alignment: Alignment.bottomLeft,
      length: _items.length + (_items.length < 3 && isOwner ? 1 : 0),
      imageGetter: (i) {
        if (_items.elementAtOrNull(i) == null) return null;
        return '$cdnUrl/${_items[i].thumbnailUrl}';
      },
      onTap: (index) {
        var data = _items.elementAtOrNull(index);
        if (data == null || isEditMode) return;

        ref
            .read(videoControllerProvider.notifier)
            .items(items, current: index + 6);
        VideoPlayerRoute(index: index + 6).push(context);
      },
      child: !isOwner
          ? null
          : (i) {
              var data = _items.elementAtOrNull(i);
              if (data == null) {
                return Center(child: FabAddBtn(height: 200, width: 120));
              }

              if (isEditMode) {
                return LongPressDraggable<String>(
                  data: data.uuid,
                  feedback: SizedBox(
                    height: .2.sh,
                    width: .24.sw,
                    child: VideoContainer(
                      cdnUrl: cdnUrl,
                      viewCount: data.viewCount,
                      thumbnailUrl: data.thumbnailUrl,
                    ),
                  ),
                  childWhenDragging: Container(color: Colors.black54),
                  child: DragTarget<String>(
                    onAcceptWithDetails: (details) {
                      final oldIndex =
                          items.indexWhere((e) => e.uuid == details.data);
                      final newIndex =
                          items.indexWhere((e) => e.uuid == data.uuid);

                      ref
                          .read(fabDraftLayoutControllerProvider(uuid).notifier)
                          .move(
                            oldIndex: oldIndex,
                            newIndex: newIndex,
                          );
                    },
                    builder: (context, _, __) {
                      return Container(
                        color: Colors.black38,
                        child: Stack(
                          children: [
                            Center(child: Icon(CupertinoIcons.move)),
                            Align(
                              alignment: Alignment.topRight,
                              child: PopupBtn(
                                items: [
                                  PopupItem(
                                    title: 'Edit',
                                    onTap: () => onEdit(ref, context, data),
                                  ),
                                  PopupItem(
                                    title: 'Delete',
                                    onTap: () => showDeleteSheet(context, data),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              }

              return Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextViewWidget(
                    text:
                        '${data.viewCount} view${data.viewCount > 1 ? 's' : ''}',
                    color: colorWhite,
                    textSize: 12.sp,
                  ),
                ),
              );
            },
    );
  }

  void onEdit(WidgetRef ref, BuildContext context, PostOut data) {
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

  void showDeleteSheet(BuildContext context, PostOut data) {
    SheetUtils.showSimpleSheet(
      context: context,
      child: DeleteSheet(onDelete: () => onDelete(data.uuid)),
    );
  }
}
