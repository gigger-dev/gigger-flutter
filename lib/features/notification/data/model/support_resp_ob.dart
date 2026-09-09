import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_gigger_app/features/notification/data/model/noti_resp_ob.dart';

part 'support_resp_ob.freezed.dart';
part 'support_resp_ob.g.dart';

@freezed
class SupportRespOb with _$SupportRespOb {
  factory SupportRespOb({
    required SupportData supporters,
    required SupportData services,
    required SupportData memberships,
    required SupportData campaigns,
  }) = _SupportRespOb;

  factory SupportRespOb.fromJson(Map<String, dynamic> json) =>
      _$SupportRespObFromJson(json);
}

@freezed
class SupportData with _$SupportData {
  factory SupportData({
    required List<NotiData> recent,
    @JsonKey(name: 'this_week') required List<NotiData> week,
    @JsonKey(name: 'this_month') required List<NotiData> month,
  }) = _SupportData;

  factory SupportData.fromJson(Map<String, dynamic> json) =>
      _$SupportDataFromJson(json);
}
