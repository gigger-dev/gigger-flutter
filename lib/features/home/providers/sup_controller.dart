import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_gigger_app/features/home/providers/new_sup_controller.dart';
import 'package:mobile_gigger_app/features/post_form/data/sup/sup_provider.dart';
import 'package:mobile_gigger_app/features/post_form/domain/sup/sup_use_case.dart';
import 'package:mobile_gigger_app/models/paginated_response_profile_fewer_details_out.dart';
import 'package:mobile_gigger_app/models/profile_fewer_details_out.dart';
import 'package:mobile_gigger_app/models/sup_created_from_enum.dart';
import 'package:mobile_gigger_app/models/sup_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sup_controller.g.dart';

@riverpod
class SupController extends _$SupController {
  @override
  Future<PaginatedResponseProfileFewerDetailsOut> build(
    SupCreatedFromEnum createdFrom,
  ) async {
    var r = await getApiV1SupUseCase(
      createdFrom: createdFrom,
      repo: ref.read(supRepoProvider),
    );

    for (var e in r.items) {
      var sups = await ref
          .read(supProfileControllerProvider(e.uuid, createdFrom).future);

      ref.read(newSupControllerProvider(e.uuid).notifier).get(sups);
    }

    return r;
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }

  Future<int> getIndex(String profileUuid) async {
    var state = await future;
    var items = List<ProfileFewerDetailsOut>.from(state.items);
    return items.indexWhere((e) => e.uuid == profileUuid);
  }
}

@riverpod
class SupProfileController extends _$SupProfileController {
  @override
  Future<List<SupOut>> build(
    String profileUuid,
    SupCreatedFromEnum createdFrom,
  ) {
    return getApiV1SupProfileUuidUseCase(
      profileUuid: profileUuid,
      createdFrom: createdFrom,
      repo: ref.read(supRepoProvider),
    );
  }

  Future<int> getIndex(String uuid) async {
    var state = await future;
    return state.indexWhere((e) => e.uuid == uuid);
  }
}

@riverpod
Future<SupOut> getSupById(Ref ref, String supUuid) {
  return getApiV1SupSupUuidGetUseCase(
    supUuid: supUuid,
    repo: ref.read(supRepoProvider),
  );
}
