import 'package:mobile_gigger_app/features/notification/data/model/noti_resp_ob.dart';
import 'package:mobile_gigger_app/features/notification/data/model/support_resp_ob.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'support_provider.g.dart';

var supportData = SupportData(
  recent: [
    NotiData(
      name: 'Username 123',
      message: 'post "My First Album" ...',
      hourAgo: '3h',
      isRead: false,
    ),
    NotiData(
      name: 'Username 123',
      message: 'post "My First Album" ...',
      hourAgo: '3h',
      isRead: true,
    ),
  ],
  week: [
    NotiData(
      name: 'Username 123',
      message: 'post "My First Album" ...',
      hourAgo: '3h',
      isRead: true,
    ),
    NotiData(
      name: 'Username 123',
      message: 'post "My First Album" ...',
      hourAgo: '3h',
      isRead: false,
    ),
  ],
  month: [
    NotiData(
      name: 'Username 123',
      message: 'post "My First Album" ...',
      hourAgo: '3h',
      isRead: false,
    ),
    NotiData(
      name: 'Username 123',
      message: 'post "My First Album" ...',
      hourAgo: '3h',
      isRead: true,
    ),
  ],
);

@Riverpod(keepAlive: true)
class Support extends _$Support {
  var items = [
    NotiData(
      name: 'Username 123',
      message: 'post "My First Album" ...',
      hourAgo: '3h',
      isRead: false,
    ),
    NotiData(
      name: 'Username 123',
      message: 'post "My First Album" ...',
      hourAgo: '3h',
      isRead: false,
    ),
  ];

  @override
  Future<SupportRespOb?> build() async {
    return SupportRespOb(
      supporters: SupportData(recent: items, week: items, month: items),
      services: SupportData(recent: items, week: items, month: items),
      memberships: SupportData(recent: items, week: items, month: items),
      campaigns: SupportData(recent: items, week: items, month: items),
    );
  }
}
