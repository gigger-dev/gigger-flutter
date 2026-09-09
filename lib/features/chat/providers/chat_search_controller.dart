import 'package:mobile_gigger_app/features/profile/data/profile_provider.dart';
import 'package:mobile_gigger_app/features/profile/domain/profile_use_case.dart';
import 'package:mobile_gigger_app/models/profile_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_search_controller.g.dart';

@riverpod
class ChatSearchController extends _$ChatSearchController {
  @override
  Future<List<ProfileOut>> build(String profileUuid) async => [];

  Future<void> search(String query) async {
    state = AsyncLoading();

    var r = await getApiV1ProfilesProfileUuidSearchUseCase(
      username: query,
      profileUuid: profileUuid,
      repo: ref.read(profileRepoProvider),
    );

    state = AsyncData(r.items);
  }
}
