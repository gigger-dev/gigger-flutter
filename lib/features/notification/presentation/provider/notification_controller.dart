import 'package:mobile_gigger_app/features/settings/data/settings_provider.dart';
import 'package:mobile_gigger_app/features/settings/domain/settings_use_case.dart';
import 'package:mobile_gigger_app/models/notification_out.dart';
import 'package:mobile_gigger_app/widgets/toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_controller.g.dart';

@Riverpod(keepAlive: true)
class NotificationController extends _$NotificationController {
  @override
  Future<List<NotificationOut>> build() {
    return getApiV1ConfigNotificationsUseCase(ref.read(settingsRepoProvider));
  }

  void refresh() {
    ref.invalidateSelf();
  }

  Future<void> delete(int id) async {
    try {
      var r = await deleteApiV1ConfigNotificationUuidUseCase(
        notificationUuid: id,
        repo: ref.read(settingsRepoProvider),
      );

      if (r.success) {
        var state = await future;
        state.removeWhere((e) => e.id == id);
        this.state = AsyncData(state);

        Toast.success(r.message);
      }
    } catch (_) {}
  }
}
