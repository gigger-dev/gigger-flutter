import 'package:mobile_gigger_app/features/profile/data/profile_provider.dart';
import 'package:mobile_gigger_app/features/profile/domain/profile_use_case.dart';
import 'package:mobile_gigger_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mobile_gigger_app/models/paginated_response_profile_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'artist_controller.g.dart';

@Riverpod(keepAlive: true)
class ArtistController extends _$ArtistController {
  @override
  Future<PaginatedResponseProfileOut> build() => get();

  Future<PaginatedResponseProfileOut> get() async {
    var uuid = await ref
        .watch(profileControllerProvider.selectAsync((v) => v?.uuid ?? ''));
    return getApiV1ProfilesProfileUuidRecommendedArtistUseCase(
      profileUuid: uuid,
      repo: ref.read(profileRepoProvider),
    );
  }

  Future<void> loadMore() async {
    await update((state) async {
      var uuid = await ref
          .read(profileControllerProvider.selectAsync((v) => v?.uuid ?? ''));

      var repo = ref.read(profileRepoProvider);

      var r = await getApiV1ProfilesProfileUuidRecommendedArtistUseCase(
        offset: state.offset + 1,
        profileUuid: uuid,
        repo: repo,
      );
      return r.copyWith(items: [...state.items, ...r.items]);
    });
  }

  Future<void> refresh() async {
    try {
      var r = await get();
      state = AsyncData(r);
    } catch (_) {}
  }
}
