import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/consts/text_style.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/outlined_btn.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

enum MediaType { image, video, both }

class SelectMediaSheet extends StatefulWidget {
  const SelectMediaSheet.image({
    super.key,
    this.title,
    this.maxAssets = 1,
    this.selectedAssets,
  }) : type = MediaType.image;

  const SelectMediaSheet.video({
    super.key,
    this.title,
    this.maxAssets = 1,
    this.selectedAssets,
  }) : type = MediaType.video;

  const SelectMediaSheet.both({
    super.key,
    this.title,
    this.maxAssets = 1,
    this.selectedAssets,
  }) : type = MediaType.both;

  final String? title;
  final MediaType type;
  final int maxAssets;
  final List<AssetEntity>? selectedAssets;

  @override
  State<SelectMediaSheet> createState() => _SelectMediaSheetState();
}

class _SelectMediaSheetState extends State<SelectMediaSheet> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title ?? 'ADD YOUR MEDIA',
            style: popupTitleStyle,
          ),
          const SizedBox(height: 40),
          OutlinedBtn(
            text: 'Add from gallery',
            onPressed: () => onTap(ImageSource.gallery),
          ),
          const SizedBox(height: 10),
          GradientFilledButton(
            title: 'Record now with camera',
            onPressed: () => onTap(ImageSource.camera),
          )
        ],
      ),
    );
  }

  Future<void> onTap(ImageSource source) async {
    if (widget.type != MediaType.both && widget.selectedAssets == null) {
      if (widget.type == MediaType.image) {
        var r = await picker.pickImage(
          source: source,
          maxHeight: 1920,
          maxWidth: 1080,
        );

        if (!mounted) return;

        context.pop(r?.path);
        return;
      }

      var r = await picker.pickVideo(source: source);
      if (!mounted) return;

      context.pop(r?.path);
      return;
    }

    if (source == ImageSource.gallery) {
      var result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          themeColor: colorRed,
          maxAssets: widget.maxAssets,
          selectedAssets: widget.selectedAssets,
          requestType: widget.type == MediaType.image
              ? RequestType.image
              : RequestType.common,
          // selectPredicate: (c, a, isSelected) {
          //   return a.title?.endsWith('.gif') != true;
          // },
        ),
      );

      if (!mounted) return;
      Object? data;

      if (result != null) {
        data = widget.maxAssets == 1 ? result.firstOrNull : result;
      }

      context.pop(data);
      return;
    }

    var result = await CameraPicker.pickFromCamera(
      context,
      locale: Locale('en'),
      pickerConfig: CameraPickerConfig(
        enableRecording: true,
        imageFormatGroup: ImageFormatGroup.jpeg,
        resolutionPreset: ResolutionPreset.high,
        theme: CameraPicker.themeData(colorRed),
        lockCaptureOrientation: DeviceOrientation.portraitUp,
      ),
    );

    if (!mounted) return;
    context.pop(result);
  }
}
