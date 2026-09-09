import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/providers/post_form_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/video_thumbnail_picker_dialog.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/video_trim_dialog.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/models/gig_list_media.dart';
import 'package:mobile_gigger_app/widgets/select_media_sheet.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class GiglistMediaWidget extends ConsumerStatefulWidget {
  const GiglistMediaWidget({
    super.key,
    this.cdnUrl,
  });

  final String? cdnUrl;

  @override
  ConsumerState<GiglistMediaWidget> createState() => _GiglistMediaWidgetState();
}

class _GiglistMediaWidgetState extends ConsumerState<GiglistMediaWidget> {
  @override
  Widget build(BuildContext context) {
    var cdnUrl = ref.watch(configProvider.select((v) => v.value?.cdnUrl));

    var state = ref.watch(postFormControllerProvider);

    if (state.gigListMedia.isEmpty) {
      return const SizedBox();
    }

    var medias = state.gigListMedia.values.toList();

    var videoExist = medias.any((e) => e.isVideo);

    var itemCount = medias.length;

    if (videoExist) {
      if (itemCount < 3) itemCount += 1;
    } else {
      if (itemCount < 6) itemCount += 1;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: SizedBox(
        height: 300,
        child: StaggeredGridView.countBuilder(
          key: ValueKey(itemCount),
          shrinkWrap: true,
          itemCount: itemCount,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          crossAxisCount: videoExist || (itemCount < 5) ? 2 : 3,
          staggeredTileBuilder: (i) => tileBuilder(i, videoExist, itemCount),
          itemBuilder: (context, index) {
            if (index >= medias.length) {
              return InkWell(
                onTap: () => showSelectMediaSheet(
                  medias,
                  state.gigListAssets,
                  state.thumbnailImageFile != null,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.add),
                ),
              );
            }

            var data = medias[index];

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey),
                image: _image(
                  data,
                  cdnUrl,
                  state.thumbnailImageFile,
                  state.thumbnailImageUrl,
                ),
              ),
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(8),
              child: InkWell(
                onTap: () => clear(index, state.gigListAssets),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorWhite,
                  ),
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.clear, color: colorBlack, size: 14),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> showSelectMediaSheet(
    List<GigListMedia> medias,
    List<AssetEntity> assets,
    bool thumbnailImageFileExist,
  ) async {
    var videoExist = medias.any((e) => e.isVideo);

    var result = await SheetUtils.showSimpleSheet(
      context: context,
      child: videoExist
          ? SelectMediaSheet.image(
              maxAssets: 3,
              selectedAssets: assets,
            )
          : SelectMediaSheet.image(
              maxAssets: 6,
              selectedAssets: assets,
            ),
    );

    if (result == null) return;

    if (result is XFile) {
      ref.read(postFormControllerProvider.notifier).gigListMedia(result.path);
      return;
    }

    var file = result as List<AssetEntity>?;
    if (file == null) return;

    ref.read(postFormControllerProvider.notifier).gigListAssets(file);

    for (var e in file) {
      if (e.mimeType!.startsWith('image')) {
        ref
            .read(postFormControllerProvider.notifier)
            .gigListMedia((await e.file)!.path);
      } else {
        if (thumbnailImageFileExist) continue;

        var f = await e.file;
        if (f == null) return;
        await videoTrim(f, true);
      }
    }
  }

  void clear(int i, List<AssetEntity> gigListAssets) {
    var assets = List<AssetEntity>.from(gigListAssets);

    ref.read(postFormControllerProvider.notifier).removeMedia(i);
    ref
        .read(postFormControllerProvider.notifier)
        .gigListAssets([...assets..removeAt(i)]);
  }

  Future<void> videoTrim(File f, [bool isGiglist = false]) async {
    var file = await showDialog<File>(
      context: context,
      builder: (_) => VideoTrimDialog(f),
    );

    if (file == null || !mounted) return;

    var r = await showDialog<List<dynamic>>(
      context: context,
      builder: (_) => VideoThumbnailPickerDialog(file),
    );

    if (r == null) return;

    if (isGiglist) {
      ref
          .read(postFormControllerProvider.notifier)
          .thumbnailImageFile(r[0] as File);
      ref
          .read(postFormControllerProvider.notifier)
          .gigListMedia(file.path, true);
    } else {
      ref.read(postFormControllerProvider.notifier).videoData(
            video: file,
            isHori: r[1] as bool,
            thumbnailImg: r[0] as File,
          );
    }
  }

  DecorationImage? _image(
    GigListMedia data,
    String? cdnUrl,
    File? thumbnailImageFile,
    String? thumbnailImageUrl,
  ) {
    if (!data.isVideo) {
      return DecorationImage(
        fit: BoxFit.cover,
        image: data.mediaUrl.contains('MEDIA')
            ? CachedNetworkImageProvider('$cdnUrl/${data.mediaUrl}')
            : FileImage(File(data.mediaUrl)),
      );
    }

    if (thumbnailImageFile != null) {
      return DecorationImage(
        fit: BoxFit.cover,
        image: FileImage(thumbnailImageFile),
      );
    }

    if (thumbnailImageUrl != null) {
      return DecorationImage(
        fit: BoxFit.cover,
        image: CachedNetworkImageProvider('$cdnUrl/$thumbnailImageUrl'),
      );
    }

    return null;
  }

  StaggeredTile? tileBuilder(int index, bool videoExist, int itemCount) {
    // if (index != 0) {
    //   return const StaggeredTile.extent(1, (1 / 2) * 290);
    // }

    if (index == 0 && itemCount < 4) {
      return const StaggeredTile.extent(1, 1 * 300);
    }

    return const StaggeredTile.extent(1, (1 / 2) * 290);
  }
}
