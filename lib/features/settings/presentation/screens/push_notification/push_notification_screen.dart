import 'package:flutter/material.dart';
import 'package:mobile_gigger_app/core/consts/color.dart';
import 'package:mobile_gigger_app/core/utils/sheet_utils.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_divider.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_item.dart';
import 'package:mobile_gigger_app/features/settings/presentation/widgets/setting_page.dart';

class PushNotificationScreen extends StatelessWidget {
  const PushNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingPage(
      title: 'Push notifications',
      children: [
        SettingItem(
          value: false,
          title: 'Silence all notifications',
          onChanged: (_) => SheetUtils.newComingSoonSheet(context),
        ),
        const SettingDivider(height: 50),
        SettingItem(
          // disable: true,
          haveArrow: true,
          title: 'Post, likes and S\'Up',
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const PostLikeRoute().push(context);
          },
        ),
        SettingItem(
          title: 'Following and followers',
          haveArrow: true,
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const FollowingFollowerRoute().push(context);
          },
        ),
        SettingItem(
          haveArrow: true,
          title: 'Direct messages',
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const DirectMessageRoute().push(context);
          },
        ),
        SettingItem(
          haveArrow: true,
          color: colorWhite,
          isRequiredPro: true,
          title: 'Calendar and appointments',
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const CalendarAppointmentRoute().push(context);
          },
        ),
        SettingItem(
          haveArrow: true,
          title: 'Support and donations from users',
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const SupportDonationRoute().push(context);
          },
        ),
        SettingItem(
          haveArrow: true,
          color: colorWhite,
          isRequiredPro: true,
          title: 'Membership subscriptions',
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const MembershipSubscriptionRoute().push(context);
          },
        ),
        SettingItem(
          haveArrow: true,
          title: 'Giglist notifications',
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const GiglistNotiRoute().push(context);
          },
        ),
        SettingItem(
          title: 'From Gigger',
          haveArrow: true,
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const FromGiggerRoute().push(context);
          },
        ),
        SettingItem(
          title: 'Emails',
          haveArrow: true,
          onTap: () {
            SheetUtils.newComingSoonSheet(context);
            // const EmailNotiRoute().push(context);
          },
        ),
      ],
    );
  }
}
