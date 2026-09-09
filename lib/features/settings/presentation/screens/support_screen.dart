import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class SupportSettingScreen extends StatelessWidget {
  const SupportSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Support',
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: TextViewWidget(
            text: 'Learn more about Gigger or contact support',
            color: Colors.grey,
          ),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Report a problem',
          onTap: () => const ReportProblemRoute().push(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Service center',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Privacy assistance FAQ',
          onTap: () => const PrivacyAssistanceRoute().push(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'App updates',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Data legislation',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Conditions of use',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
      ],
    );
  }
}
