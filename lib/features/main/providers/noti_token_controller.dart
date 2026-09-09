import 'package:mobile_gigger_app/core/helpers/messaging_helper.dart';
import 'package:mobile_gigger_app/core/utils/get_device_uuid.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/features/settings/data/settings_provider.dart';
import 'package:mobile_gigger_app/features/settings/domain/settings_use_case.dart';
import 'package:mobile_gigger_app/models/device_token_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'noti_token_controller.g.dart';

@riverpod
class NotiTokenController extends _$NotiTokenController {
  @override
  Future<String?> build() async {
    var fcmToken = await MessagingHelper.getToken();

    await refresh('$fcmToken');

    return fcmToken;
  }

  Future<void> refresh(String fcmToken) async {
    var deviceUuid = await getDeviceUuid();

    var profile = await ref.read(profileControllerProvider.future);

    if (profile == null) return;

    await postApiV1ConfigFcmTokenUseCase(
      body: DeviceTokenIn(
        fcmToken: fcmToken,
        deviceUuid: deviceUuid,
        profileUuid: profile.uuid,
      ),
      repo: ref.read(settingsRepoProvider),
    );
  }
}
