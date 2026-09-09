import 'package:mobile_gigger_app/features/notification/data/model/noti_resp_ob.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_provider.g.dart';

@Riverpod(keepAlive: true)
class Message extends _$Message {
  @override
  Future<NotiRespOb?> build() async {
    return NotiRespOb(general: [], calendar: [], giglist: [], proUsers: []);
  }
}
