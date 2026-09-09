import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_gigger_app/core/route/router_config.dart';
import 'package:mobile_gigger_app/features/auth/presentation/forgot_screen.dart';
import 'package:mobile_gigger_app/features/auth/presentation/login_screen.dart';
import 'package:mobile_gigger_app/features/auth/presentation/otp_screen.dart';
import 'package:mobile_gigger_app/features/auth/presentation/register_screen.dart';
import 'package:mobile_gigger_app/features/availability/availability_screen.dart';
import 'package:mobile_gigger_app/features/calendar/calendar_screen.dart';
import 'package:mobile_gigger_app/features/chat/chat_list_screen.dart';
import 'package:mobile_gigger_app/features/chat/chat_screen.dart';
import 'package:mobile_gigger_app/features/chat/user_search_screen.dart';
import 'package:mobile_gigger_app/features/connection/connection_screen.dart';
import 'package:mobile_gigger_app/features/draft/draft_screen.dart';
import 'package:mobile_gigger_app/features/event_form/event_form_screen.dart';
import 'package:mobile_gigger_app/features/event_form/line_up_list_screen.dart';
import 'package:mobile_gigger_app/features/events/presentation/event_scroll_screen.dart';
import 'package:mobile_gigger_app/features/giglist/giglist_scroll_screen.dart';
import 'package:mobile_gigger_app/features/giglist_fav/giglist_fav_screen.dart';
import 'package:mobile_gigger_app/features/interest/interest_screen.dart';
import 'package:mobile_gigger_app/features/main/main_screen.dart';
import 'package:mobile_gigger_app/features/manage_event/manage_event_screen.dart';
import 'package:mobile_gigger_app/features/manage_giglist/manage_giglist_screen.dart';
import 'package:mobile_gigger_app/features/notification/presentation/noti_screen.dart';
import 'package:mobile_gigger_app/features/post_form/presentation/post_form_screen.dart';
import 'package:mobile_gigger_app/features/profile/presentation/control_room_screen.dart';
import 'package:mobile_gigger_app/features/profile/presentation/profile_screen.dart';
import 'package:mobile_gigger_app/features/profile_setup/profile_setup_screen.dart';
import 'package:mobile_gigger_app/features/search/presentation/screens/all_result_screen.dart';
import 'package:mobile_gigger_app/features/search/presentation/screens/event_result_screen.dart';
import 'package:mobile_gigger_app/features/search/presentation/screens/gigger_result_screen.dart';
import 'package:mobile_gigger_app/features/search/presentation/screens/giglist_result_screen.dart';
import 'package:mobile_gigger_app/features/search/presentation/screens/search_filter_screen.dart';
import 'package:mobile_gigger_app/features/search/presentation/screens/search_screen.dart';
import 'package:mobile_gigger_app/features/search/presentation/screens/video_result_screen.dart';
import 'package:mobile_gigger_app/features/search/presentation/widgets/date_time_picker/date_time_picker.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/customize_theme_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/manage_account_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/partnership/ads_archive_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/partnership/partnership_setting_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/partnership/perf_ads.screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/partnership_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/privacy/activity_status_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/privacy/blocked_account_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/privacy/calendar_privacy_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/privacy/campaign_support_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/privacy/mention_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/privacy/message_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/privacy/my_archive_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/privacy/post_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/privacy/privacy_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/privacy/sensitive_content_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/push_notification/calendar_appointment_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/push_notification/direct_message_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/push_notification/email_noti_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/push_notification/following_follower_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/push_notification/from_gigger_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/push_notification/giglist_noti_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/push_notification/membership_subscription_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/push_notification/post_like_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/push_notification/push_notification_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/push_notification/support_donation_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/security/download_backup_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/security/email_from_giger_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/security/email_password_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/security/login_activity_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/security/security_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/security/two_factor_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/setting_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/subscribe_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/support/privacy_assistance_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/support/report_problem_details_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/support/report_problem_screen.dart';
import 'package:mobile_gigger_app/features/settings/presentation/screens/support_screen.dart';
import 'package:mobile_gigger_app/features/splash/splash_screen.dart';
import 'package:mobile_gigger_app/features/sup/sup_all_screen.dart';
import 'package:mobile_gigger_app/features/support/support_result_screen.dart';
import 'package:mobile_gigger_app/features/support/support_screen.dart';
import 'package:mobile_gigger_app/features/video_player/video_player_screen.dart';
import 'package:mobile_gigger_app/models/availability_out.dart';
import 'package:mobile_gigger_app/models/event_out.dart';
import 'package:mobile_gigger_app/models/post_form_extra.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'app_router.g.dart';
part 'routes/setting_routes.dart';

@TypedGoRoute<SplashRoute>(path: '/')
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(_, __) => const SplashScreen();
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  final bool showProfiles;

  LoginRoute({this.showProfiles = true});

  @override
  Widget build(_, __) => LoginScreen(showProfiles: showProfiles);
}

@TypedGoRoute<ForgotRoute>(path: '/forgot')
class ForgotRoute extends GoRouteData {
  const ForgotRoute({this.initialPage = 0});

  final int initialPage;

  @override
  Widget build(_, __) => ForgotScreen(initialPage);
}

@TypedGoRoute<RegisterRoute>(path: '/register')
class RegisterRoute extends GoRouteData {
  const RegisterRoute();

  @override
  Widget build(_, __) => const RegisterScreen();
}

@TypedGoRoute<OTPRoute>(path: '/otp')
class OTPRoute extends GoRouteData {
  const OTPRoute();

  @override
  Widget build(_, __) => OTPScreen();
}

@TypedGoRoute<InterestRoute>(path: '/interest')
class InterestRoute extends GoRouteData {
  const InterestRoute();

  @override
  Widget build(_, __) => InterestScreen();
}

@TypedGoRoute<ProfileSetupRoute>(path: '/profile_setup')
class ProfileSetupRoute extends GoRouteData {
  const ProfileSetupRoute();

  @override
  Widget build(_, __) => ProfileSetupScreen();
}

@TypedGoRoute<AvailabilityRoute>(path: '/availability')
class AvailabilityRoute extends GoRouteData {
  const AvailabilityRoute({
    required this.status,
    required this.$extra,
    this.viewOnly = true,
  });

  final bool status;
  final bool viewOnly;
  final List<AvailabilityOut> $extra;

  @override
  Widget build(_, __) => AvailabilityScreen(
        status: status,
        viewOnly: viewOnly,
        availability: $extra,
      );
}

@TypedGoRoute<MainRoute>(
  path: '/main',
  routes: [
    TypedGoRoute<SupRoute>(path: 'sup'),
    TypedGoRoute<ProfileRoute>(path: 'profile'),
    TypedGoRoute<ConnectionRoute>(path: 'connection'),
    TypedGoRoute<CalendarRoute>(path: 'calendar'),
    TypedGoRoute<ControlRoomRoute>(
      path: 'control_room',
      routes: [
        TypedGoRoute<ManageEventRoute>(path: 'manage_event'),
        TypedGoRoute<DraftRoute>(path: 'draft'),
        TypedGoRoute<ManageGiglistRoute>(
          path: 'manage_giglist',
          routes: [
            TypedGoRoute<GiglistFavRoute>(path: 'fav'),
          ],
        ),
      ],
    ),
    TypedGoRoute<VideoPlayerRoute>(path: 'video'),
    TypedGoRoute<PostFormRoute>(path: 'post_form'),
    TypedGoRoute<EventFormRoute>(
      path: 'event_form',
      routes: [
        TypedGoRoute<LineUpListRoute>(path: 'line_up'),
      ],
    ),
    TypedGoRoute<SearchRoute>(
      path: 'search',
      routes: [
        TypedGoRoute<GiggerResultRoute>(path: 'gigger'),
        TypedGoRoute<GiglistResultRoute>(path: 'giglist'),
        TypedGoRoute<VideoResultRoute>(path: 'video'),
        TypedGoRoute<AllResultRoute>(path: 'all'),
        TypedGoRoute<EventResultRoute>(path: 'event'),
      ],
    ),
    TypedGoRoute<DateTimePickerRoute>(path: 'date_time_picker'),
    TypedGoRoute<SearchFilterRoute>(path: 'search_filter'),
    TypedGoRoute<GiglistScrollRoute>(path: 'giglist'),
    TypedGoRoute<EventScrollRoute>(path: 'event'),
    TypedGoRoute<SupportRoute>(
      path: 'support',
      routes: [
        TypedGoRoute<SupportResultRoute>(path: 'result'),
      ],
    ),
    TypedGoRoute<NotiRoute>(
      path: 'noti',
      routes: [
        TypedGoRoute<ChatRoute>(
          path: 'chat',
          routes: [
            TypedGoRoute<UserSearchRoute>(path: 'search'),
          ],
        ),
      ],
    ),
    TypedGoRoute<SettingRoute>(
      path: 'setting',
      routes: [
        TypedGoRoute<ManageAccountRoute>(path: 'manage_account'),
        TypedGoRoute<PrivacyRoute>(
          path: 'privacy',
          routes: [
            TypedGoRoute<PostRoute>(path: 'post'),
            TypedGoRoute<MentionRoute>(path: 'mention'),
            TypedGoRoute<ActivityStatusRoute>(path: 'activity_status'),
            TypedGoRoute<MessageRoute>(path: 'message'),
            TypedGoRoute<CalendarPrivacyRoute>(path: 'calendar_privacy'),
            TypedGoRoute<MyArchiveRoute>(path: 'who_can_see_my_archive'),
            TypedGoRoute<SensitiveContentRoute>(path: 'sensitive_content'),
            TypedGoRoute<BlockedAccountRoute>(path: 'blocked_account'),
            TypedGoRoute<CampaignSupportRoute>(path: 'campaign_and_support'),
            //TypedGoRoute<AvailabilityRoute>(path: 'availability'),
          ],
        ),
        TypedGoRoute<SecurityRoute>(
          path: 'security',
          routes: [
            TypedGoRoute<EmailPasswordRoute>(path: 'email_passw'),
            TypedGoRoute<TwoFactorRoute>(path: 'two_factor'),
            TypedGoRoute<LoginActivityRoute>(path: 'login_activity'),
            TypedGoRoute<EmailFromGiggerRoute>(path: 'email_from_gigger'),
            TypedGoRoute<DownloadBackupRoute>(path: 'download_backup'),
          ],
        ),
        TypedGoRoute<PushNotificationRoute>(
          path: 'push_notification',
          routes: [
            TypedGoRoute<PostLikeRoute>(path: 'post_like'),
            TypedGoRoute<FollowingFollowerRoute>(
                path: 'following_and_follower'),
            TypedGoRoute<DirectMessageRoute>(path: 'direct_message'),
            TypedGoRoute<CalendarAppointmentRoute>(
                path: 'calendar_appointment'),
            TypedGoRoute<SupportDonationRoute>(path: 'support_and_donation'),
            TypedGoRoute<MembershipSubscriptionRoute>(path: 'membership_sub'),
            TypedGoRoute<GiglistNotiRoute>(path: 'giglist_noti'),
            TypedGoRoute<FromGiggerRoute>(path: 'from_gigger'),
            TypedGoRoute<EmailNotiRoute>(path: 'email_noti'),
          ],
        ),
        TypedGoRoute<PartnershipRoute>(
          path: 'partnership',
          routes: [
            TypedGoRoute<PrefAdsRoute>(path: 'pref_ads'),
            TypedGoRoute<AdsArchiveRoute>(path: 'ads_archive'),
            TypedGoRoute<PartnershipSettingRoute>(path: 'partnership'),
          ],
        ),
        TypedGoRoute<CustomizeThemeRoute>(path: 'customize_theme'),
        TypedGoRoute<SupportSettingRoute>(
          path: 'support',
          routes: [
            TypedGoRoute<ReportProblemRoute>(
              path: 'report_problem',
              routes: [
                TypedGoRoute<ReportProblemDetailRoute>(path: 'detail'),
              ],
            ),
            TypedGoRoute<PrivacyAssistanceRoute>(path: 'assistance'),
          ],
        ),
        TypedGoRoute<SubscribeRoute>(path: 'subscribe'),
      ],
    ),
  ],
)
class MainRoute extends GoRouteData {
  const MainRoute();

  @override
  Widget build(_, __) => const MainScreen();
}

class PostFormRoute extends GoRouteData {
  const PostFormRoute({
    this.title,
    this.caption,
    this.uuid,
    this.musicTitle,
    this.wageRequested,
    this.place,
    this.$extra,
  });

  final String? uuid;
  final String? title;
  final String? caption;
  final String? place;
  final String? musicTitle;
  final int? wageRequested;
  final PostFormExtra? $extra;

  @override
  Widget build(_, __) => PostFormScreen(
        uuid: uuid,
        title: title,
        caption: caption,
        location: place,
        musicTitle: musicTitle,
        payload: $extra?.payload,
        hashtags: $extra?.hashtags,
        wageRequested: wageRequested,
      );
}

class EventFormRoute extends GoRouteData {
  final EventOut? $extra;

  EventFormRoute({this.$extra});

  @override
  Widget build(_, __) => EventFormScreen(data: $extra);
}

class LineUpListRoute extends GoRouteData {
  const LineUpListRoute();

  @override
  Widget build(_, __) => LineUpListScreen();
}

class VideoPlayerRoute extends GoRouteData {
  const VideoPlayerRoute({this.index, this.uuid});

  final int? index;
  final String? uuid;

  @override
  Widget build(_, __) => VideoPlayerScreen(index: index ?? 0, uuid: uuid);
}

class ProfileRoute extends GoRouteData {
  const ProfileRoute({this.uuid, this.isInitialEdit = false});

  final String? uuid;
  final bool isInitialEdit;

  @override
  Widget build(_, __) => ProfileScreen(
        uuid: uuid,
        isInitialEdit: isInitialEdit,
      );
}

class ConnectionRoute extends GoRouteData {
  const ConnectionRoute({this.initialIndex = 0});

  final int initialIndex;

  @override
  Widget build(_, __) => ConnectionScreen(initialIndex: initialIndex);
}

class SearchRoute extends GoRouteData {
  const SearchRoute();

  @override
  Widget build(_, __) => const SearchScreen();
}

class SearchFilterRoute extends GoRouteData {
  const SearchFilterRoute({this.index = 0});

  final int index;

  @override
  Widget build(_, __) => SearchFilterScreen(index: index);
}

class DateTimePickerRoute extends GoRouteData {
  const DateTimePickerRoute({
    this.endTime,
    this.startTime,
    this.isMultiple = false,
    this.initialSelectedDate,
    this.firstDay,
  });

  final bool isMultiple;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? initialSelectedDate;

  final DateTime? firstDay;

  @override
  Widget build(_, __) => DateTimePicker(
        endTime: endTime,
        firstDay: firstDay,
        startTime: startTime,
        isMultiple: isMultiple,
        initialSelectedDate: initialSelectedDate,
      );
}

class GiglistScrollRoute extends GoRouteData {
  const GiglistScrollRoute({
    this.uuid,
    this.index,
    this.isVisitor,
    this.profileUuid,
    this.isFav,
  });

  final int? index;
  final bool? isFav;
  final String? uuid;
  final bool? isVisitor;
  final String? profileUuid;

  @override
  Widget build(_, __) => GiglistScrollScreen(
        uuid: uuid,
        index: index,
        isFav: isFav,
        isVisitor: isVisitor,
        profileUuid: profileUuid,
      );
}

class NotiRoute extends GoRouteData {
  const NotiRoute({this.index = 0});

  final int index;

  @override
  Widget build(_, __) => NotiScreen(index: index);
}

class ChatRoute extends GoRouteData {
  const ChatRoute({
    this.uuid,
    this.type,
    this.$extra,
    this.dataUuid,
    this.channelId,
    this.giglistTitle,
  });

  final String? uuid;
  final String? type;
  final String? dataUuid;
  final String? channelId;
  final Channel? $extra;

  final String? giglistTitle;

  @override
  Widget build(_, __) => ChatScreen(
        uuid: uuid,
        type: type,
        channel: $extra,
        dataUuid: dataUuid,
        channelId: channelId,
        giglistTitle: giglistTitle,
      );
}

class SupportRoute extends GoRouteData {
  const SupportRoute(this.$extra);

  final ProfileOut $extra;

  @override
  Widget build(_, __) => SupportScreen($extra);
}

class SupportResultRoute extends GoRouteData {
  const SupportResultRoute(this.$extra);

  final ProfileOut $extra;

  @override
  Widget build(_, __) => SupportResultScreen($extra);
}

class ChatListRoute extends GoRouteData {
  const ChatListRoute();

  @override
  Widget build(_, __) => ChatListScreen();
}

class GiggerResultRoute extends GoRouteData {
  const GiggerResultRoute({
    required this.name,
    required this.isPro,
    required this.genre,
    required this.role,
    required this.instrument,
    required this.startDate,
    required this.endDate,
  });

  final bool isPro;
  final String? name;
  final String? role;
  final String? genre;
  final String? instrument;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  Widget build(_, __) => GiggerResultScreen(
        name: name,
        role: role,
        isPro: isPro,
        genre: genre,
        endDate: endDate,
        startDate: startDate,
        instrument: instrument,
      );
}

class GiglistResultRoute extends GoRouteData {
  final num? price;
  final String title;
  final bool isPerformer;
  final bool isLookingFor;

  GiglistResultRoute({
    required this.price,
    required this.title,
    required this.isPerformer,
    required this.isLookingFor,
  });

  @override
  Widget build(_, __) => GiglistResultScreen(
        title: title,
        price: price,
        isPerformer: isPerformer,
        isLookingFor: isLookingFor,
      );
}

class VideoResultRoute extends GoRouteData {
  const VideoResultRoute({
    required this.title,
    required this.keywords,
    required this.genre,
  });

  final String title;
  final String keywords;
  final String? genre;

  @override
  Widget build(_, __) => VideoResultScreen(
        title: title,
        genre: genre,
        keywords: keywords,
      );
}

class AllResultRoute extends GoRouteData {
  const AllResultRoute({
    required this.keyword,
  });

  final String keyword;

  @override
  Widget build(_, __) => AllResultScreen(
        keyword: keyword,
      );
}

class EventResultRoute extends GoRouteData {
  const EventResultRoute({
    required this.keyword,
  });

  final String keyword;

  @override
  Widget build(_, __) => EventResultScreen(
        keyword: keyword,
      );
}

class UserSearchRoute extends GoRouteData {
  const UserSearchRoute();

  @override
  Widget build(_, __) => UserSearchScreen();
}

class ControlRoomRoute extends GoRouteData {
  const ControlRoomRoute();

  @override
  Widget build(_, __) => ControlRoomScreen();
}

class ManageEventRoute extends GoRouteData {
  const ManageEventRoute();

  @override
  Widget build(_, __) => ManageEventScreen();
}

class DraftRoute extends GoRouteData {
  const DraftRoute();

  @override
  Widget build(_, __) => DraftScreen();
}

class EventScrollRoute extends GoRouteData {
  const EventScrollRoute({this.index, this.$extra, this.uuid});

  final int? index;
  final String? uuid;
  final List<EventOut>? $extra;

  @override
  Widget build(_, __) => EventScrollScreen(
        uuid: uuid,
        items: $extra,
        index: index ?? 0,
      );
}

class SupRoute extends GoRouteData {
  const SupRoute({required this.uuid});

  final String uuid;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Page<void> buildPage(_, state) {
    return BottomSheetPage(
      key: state.pageKey,
      child: SupAllScreen(uuid: uuid),
    );
  }
}

class BottomSheetPage<T> extends Page<T> {
  final Widget child;

  const BottomSheetPage({required this.child, super.key});

  @override
  Route<T> createRoute(BuildContext context) {
    return ModalBottomSheetRoute<T>(
      settings: this,
      builder: (_) => child,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

class CalendarRoute extends GoRouteData {
  const CalendarRoute();

  @override
  Widget build(_, __) => CalendarScreen();
}

class GiglistFavRoute extends GoRouteData {
  const GiglistFavRoute();

  @override
  Widget build(_, __) => GiglistFavScreen();
}

class ManageGiglistRoute extends GoRouteData {
  const ManageGiglistRoute();

  @override
  Widget build(_, __) => ManageGiglistScreen();
}
