import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class LoginActivityScreen extends StatefulWidget {
  const LoginActivityScreen({super.key});

  @override
  State<LoginActivityScreen> createState() => _LoginActivityScreenState();
}

class _LoginActivityScreenState extends State<LoginActivityScreen> {
  List<String> get items => ['Rome, Italy', 'London, UK'];

  List<String> get descriptions => [
        'Active now on Xiaomi MI11 Lite 5G',
        'Xiaomi MI10 Lite 5G',
      ];

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Login activity',
      children: [
        const SettingItem(title: 'Last login:'),
        const SettingItem(
          title: 'Rome, Italy - 25 Jun 2022',
          color: Colors.grey,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: SettingDivider(),
        ),
        const SettingItem(
          title: 'Devices you are signed in:',
          fontSize: 16,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var data = items[index];

            var isSelected = index == 0;

            return ListTile(
              dense: true,
              title: TextViewWidget(text: data),
              subtitle: TextViewWidget(
                text: descriptions[index],
                color: colorTextGrey,
              ),
              trailing: !isSelected
                  ? TextButton(
                      onPressed: onLogout,
                      child: const TextViewWidget(
                        text: 'Logout',
                        color: colorTextRed,
                      ),
                    )
                  : const Icon(Icons.check, color: colorRed, size: 28),
            );
          },
        )
      ],
    );
  }

  void onLogout() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        decoration: const BoxDecoration(color: colorBlack),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: context.pop,
              icon: const Icon(Icons.clear, color: colorWhite, size: 30),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 60, bottom: 100),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextViewWidget(
                      text: 'Logging out this device',
                      color: colorRed,
                    ),
                    SizedBox(height: 6),
                    TextViewWidget(
                      text: 'Xiaomi MI11 Lite 5G',
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20),
                    TextViewWidget(
                      text: 'You are logging out of this device, are you sure?',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () => context.pop(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: colorWhite),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Center(
                child: TextViewWidget(
                  text: 'Yes, logout from the device',
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
