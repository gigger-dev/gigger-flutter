import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';

class ReportProblemScreen extends StatelessWidget {
  const ReportProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Report a problem',
      children: [
        SettingItem(
          haveArrow: true,
          title: 'Report spam or misuse',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          haveArrow: true,
          title: 'Report a problem',
          onTap: () => SheetUtils.newComingSoonSheet(context),
          // onTap: () => const ReportProblemDetailRoute().push(context),
        ),
      ],
    );
  }
}
