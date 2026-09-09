import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_gigger_app/models/token_out.dart';

part 'profile_save_data.freezed.dart';
part 'profile_save_data.g.dart';

@freezed
class ProfileSaveData with _$ProfileSaveData {
  factory ProfileSaveData({
    required String uuid,
    required TokenOut token,
  }) = _ProfileSaveData;

  factory ProfileSaveData.fromJson(Map<String, dynamic> json) =>
      _$ProfileSaveDataFromJson(json);
}
