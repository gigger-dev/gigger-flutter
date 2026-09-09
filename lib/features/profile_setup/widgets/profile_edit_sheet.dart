import 'dart:io';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/widgets/loading_button.dart';
import 'package:mobile_gigger_app/widgets/outlined_btn.dart';
import 'package:mobile_gigger_app/widgets/select_media_sheet.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class ProfileEditSheet extends StatefulWidget {
  const ProfileEditSheet({
    super.key,
    required this.file,
  });

  final File file;

  @override
  State<ProfileEditSheet> createState() => _ProfileEditSheetState();
}

class _ProfileEditSheetState extends State<ProfileEditSheet> {
  final controller = CustomImageCropController();
  late File file;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    file = widget.file;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 1.sw,
            height: .4.sh,
            child: CustomImageCrop(
              image: FileImage(file),
              forceInsideCropArea: true,
              cropController: controller,
              overlayColor: Colors.grey.shade900,
              backgroundColor: Colors.grey.shade900,
              imageFit: CustomImageFit.fitVisibleSpace,
            ),
          ),
          const SizedBox(height: 20),
          const TextViewWidget(text: 'Drag and resize'),
          const SizedBox(height: 40),
          OutlinedBtn(onPressed: onChangeImage, text: 'Change image'),
          const SizedBox(height: 6),
          LoadingButton(title: 'Save', isLoading: loading, onPressed: onSave)
        ],
      ),
    );
  }

  Future<void> onChangeImage() async {
    var path = await SheetUtils.showSimpleSheet<String>(
      context: context,
      child: SelectMediaSheet.image(
        title: 'Select Profile Image',
      ),
    );

    if (path == null) return;

    file = File(path);
    setState(() {});
  }

  Future<void> onSave() async {
    loading = true;
    setState(() {});

    var r = await controller.onCropImage();

    if (!mounted) return;
    context.pop(r);
  }
}
