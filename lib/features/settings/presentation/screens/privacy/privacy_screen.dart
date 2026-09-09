import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/route/app_router.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';
import 'package:mobile_gigger_app/widgets/text_view_widget.dart';

class PrivacyScreen extends ConsumerWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var profile = ref.watch(profileControllerProvider).value!;

    return SettingPage(
      title: 'Privacy',
      children: [
        SettingItem(
          title: 'Private account',
          value: profile.isPrivateProfile,
          onChanged: (value) {
            ref.read(profileControllerProvider.notifier).togglePrivate();
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: TextViewWidget(
            text:
                'In private mode users will not see your fab nine, contacts, calendar; they will not be able to mention you and you will have to accept every invitation or message. You will be less visible in searches.',
            color: colorTextGrey,
            textSize: 12,
          ),
        ),
        const SettingDivider(height: 30),
        SettingItem(
          title: 'Post',
          haveArrow: true,
          onTap: () => const PostRoute().push(context),
        ),
        SettingItem(
          title: 'Mentions',
          haveArrow: true,
          onTap: () => const MentionRoute().push(context),
        ),
        SettingItem(
          title: 'Activity status',
          haveArrow: true,
          onTap: () => const ActivityStatusRoute().push(context),
        ),
        SettingItem(
          title: 'Messages',
          haveArrow: true,
          onTap: () => const MessageRoute().push(context),
        ),
        SettingItem(
          title: 'Calendar Privacy Settings',
          haveArrow: true,
          isRequiredPro: true,
          onTap: () => const CalendarPrivacyRoute().push(context),
        ),
        SettingItem(
          title: 'Who can see my Archive',
          haveArrow: true,
          isRequiredPro: true,
          onTap: () => const MyArchiveRoute().push(context),
        ),
        SettingItem(
          title: 'Sensitive contents',
          haveArrow: true,
          onTap: () => const SensitiveContentRoute().push(context),
        ),
        SettingItem(
          title: 'Blocked accounts',
          haveArrow: true,
          onTap: () => const BlockedAccountRoute().push(context),
        ),
        SettingItem(
          title: 'Campaigns and support',
          haveArrow: true,
          onTap: () => const CampaignSupportRoute().push(context),
        ),
        SettingItem(
          title: 'Availablity',
          haveArrow: true,
          onTap: () => AvailabilityRoute(
            viewOnly: false,
            $extra: profile.availability,
            status: profile.availabilityStatus,
          ).push(context),
        ),
      ],
    );
  }
}
