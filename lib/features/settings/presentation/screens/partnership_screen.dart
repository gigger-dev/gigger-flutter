import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';

class PartnershipScreen extends StatelessWidget {
  const PartnershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Your advertisements / Partnerships',
      children: [
        SettingItem(
          haveArrow: true,
          title: 'Info about advertisements',
          onTap: () => SheetUtils.newComingSoonSheet(context),
        ),
        SettingItem(
          title: 'Preferences on ads',
          haveArrow: true,
          onTap: () => SheetUtils.newComingSoonSheet(context),
          // onTap: () => const PrefAdsRoute().push(context),
        ),
        const SettingDivider(height: 50),
        SettingItem(
          title: 'Your ads archive',
          haveArrow: true,
          onTap: () => SheetUtils.newComingSoonSheet(context),
          // onTap: () => const AdsArchiveRoute().push(context),
        ),
        SettingItem(
          title: 'Partnerships (soon available)',
          haveArrow: true,
          onTap: () => SheetUtils.newComingSoonSheet(context),
          // onTap: () => const PartnershipSettingRoute().push(context),
        ),
      ],
    );
  }
}
