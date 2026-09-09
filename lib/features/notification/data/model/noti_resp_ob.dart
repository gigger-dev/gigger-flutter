import 'package:freezed_annotation/freezed_annotation.dart';

part 'noti_resp_ob.freezed.dart';
part 'noti_resp_ob.g.dart';

@freezed
class NotiRespOb with _$NotiRespOb {
  factory NotiRespOb({
    required List<NotiData> general,
    required List<NotiData> calendar,
    required List<NotiData> giglist,
    @JsonKey(name: 'pro_users') required List<NotiData> proUsers,
  }) = _NotiRespOb;

  factory NotiRespOb.fromJson(Map<String, dynamic> json) =>
      _$NotiRespObFromJson(json);
}

@freezed
class NotiData with _$NotiData {
  factory NotiData({
    required String name,
    required String message,
    @JsonKey(name: 'hour_ago') required String hourAgo,
    @JsonKey(name: 'is_read') required bool isRead,
  }) = _NotiData;

  factory NotiData.fromJson(Map<String, dynamic> json) =>
      _$NotiDataFromJson(json);
}
