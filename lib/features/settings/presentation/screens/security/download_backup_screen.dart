import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/gradient_filled_button.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class DownloadBackupScreen extends StatelessWidget {
  const DownloadBackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Download backup',
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: TextViewWidget(
            text:
                'We will email you a link to download the content you have uploaded and your profile information. It may take a few hours to complete the request.',
            textSize: 13,
            color: colorTextGrey,
          ),
        ),
        SizedBox(height: .08.sh),
        const Icon(
          CupertinoIcons.cloud_download,
          color: colorWhite,
          size: 90,
        ),
        const SizedBox(height: 20),
        const TextViewWidget(
          text: 'Download a backup of your shared\ncontents and informations',
          textSize: 13,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: .1.sh),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            style: const TextStyle(fontSize: 13, color: colorWhite),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              hintStyle: TextStyle(fontSize: 13),
              hintText: 'Insert email address ...',
            ),
          ),
        ),
        SizedBox(height: .1.sh),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GradientFilledButton(
            title: 'Request download',
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
