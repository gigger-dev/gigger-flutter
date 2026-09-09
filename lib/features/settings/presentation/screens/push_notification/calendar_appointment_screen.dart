import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_selector.dart';

class CalendarAppointmentScreen extends StatelessWidget {
  const CalendarAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Calendar and appointments',
      children: [
        SettingItem(
          title: 'Calendar notifications',
          isRequiredPro: true,
          value: true,
          onChanged: (value) {},
        ),
        SettingItem(
          isRequiredPro: true,
          title: 'Appointments notifications',
          value: true,
          onChanged: (value) {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: SettingDivider(),
        ),
        SettingSelector(
          items: const [
            'All users (Free, Pro, Band)',
            'Only from Pro users or followers',
            'No'
          ],
          value: 0,
          footer: 'When someone send you a request',
          onSelected: (value) {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: SettingDivider(),
        ),
        SettingSelector(
          items: const [
            'All participating users and organizer',
            'Only from organizer / administrator',
            'No'
          ],
          value: 0,
          footer: 'When someone edits an event or appointment',
          onSelected: (value) {},
        ),
      ],
    );
  }
}
