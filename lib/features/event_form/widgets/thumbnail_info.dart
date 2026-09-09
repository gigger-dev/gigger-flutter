import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/event_form/providers/event_form_controller.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/thumbnail_widget.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/video_thumbnail_picker_dialog.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/widgets/video_trim_dialog.dart';
import 'package:mobile_gigger_app/features/settings/presentation/providers/config_provider.dart';
import 'package:mobile_gigger_app/gen/assets.gen.dart';
import 'package:mobile_gigger_app/widgets/select_media_sheet.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ThumbnailInfo extends ConsumerStatefulWidget {
  const ThumbnailInfo({super.key});

  @override
  ConsumerState<ThumbnailInfo> createState() => _ThumbnailInfoState();
}

class _ThumbnailInfoState extends ConsumerState<ThumbnailInfo> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(eventFormControllerProvider);
    var thumbnailFile = state.thumbnailFile;
    var thumbnailUrl = state.thumbnailUrl;

    if (thumbnailFile != null) {
      return ThumbnailWidget(
        aspectRatio: 9 / 16,
        thumbnailImageFile: File(thumbnailFile),
        onTap: () => showSelectMediaSheet(ref, context),
      );
    }

    if (thumbnailUrl != null) {
      var cdnUrl = ref.watch(configProvider.select((v) => v.value!.cdnUrl));

      return ThumbnailWidget(
        cdnUrl: cdnUrl,
        aspectRatio: 9 / 16,
        thumbnailImageUrl: thumbnailUrl,
        onTap: () => showSelectMediaSheet(ref, context),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: InkWell(
        onTap: () => showSelectMediaSheet(ref, context),
        child: Column(
          children: [
            Image.asset(
              Assets.images.giUpload.path,
              height: 60,
            ),
            SizedBox(height: 15),
            const Center(
              child: TextViewWidget(text: 'Upload Cover', textSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showSelectMediaSheet(WidgetRef ref, BuildContext context) async {
    var xfile = await SheetUtils.showSimpleSheet(
      context: context,
      child: SelectMediaSheet.both(),
    );

    var file = xfile as AssetEntity?;

    if (file == null) return;

    if (file.mimeType!.startsWith('image')) {
      ref
          .read(eventFormControllerProvider.notifier)
          .thumbnailFile((await file.file)!.path);
    } else {
      var f = await file.file;
      if (f == null) return;
      await videoTrim(f);
    }
  }

  Future<void> videoTrim(File f) async {
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

    ref.read(eventFormControllerProvider.notifier).videoData(
          video: file,
          isHori: r[1] as bool,
          thumbnailImg: r[0] as File,
        );
  }
}
