import 'package:mobile_gigger_app/features/profile/data/profile_provider.dart';
import 'package:mobile_gigger_app/features/profile/domain/profile_use_case.dart';
import 'package:mobile_gigger_app/models/profile_fewer_details_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_tag_controller.g.dart';

@Riverpod(keepAlive: true)
class UserTagAllController extends _$UserTagAllController {
  @override
  List<ProfileFewerDetailsOut> build() => [];

  void add(List<ProfileFewerDetailsOut> items) {
    for (var e in items) {
      if (state.contains(e)) continue;

      state.add(e);
    }
  }
}

@Riverpod(keepAlive: true)
class UserTagController extends _$UserTagController {
  @override
  List<ProfileFewerDetailsOut> build(String profileUuid) => [];

  Future<void> search(String query) async {
    var r = await getApiV1ProfilesProfileUuidFollowersSearchUseCase(
      username: query,
      profileUuid: profileUuid,
      repo: ref.read(profileRepoProvider),
    );

    var items = List<ProfileFewerDetailsOut>.from(r);

    items.removeWhere((e) => e.uuid == profileUuid);

    state = items;
    ref.read(userTagAllControllerProvider.notifier).add(items);
  }
}
